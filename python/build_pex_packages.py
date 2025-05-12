#!/usr/bin/env python3
"""
Build PEX packages for Python tools and publish them to GitHub OCI registry.
"""

import argparse
import json
import os
import platform
import re
import subprocess
import sys
import tarfile
import tempfile
from pathlib import Path
from typing import Dict, List, Optional, Tuple

import requests
import semver
import yaml
import venv
import shutil


class PexBuilder:
    """Build PEX packages for Python tools and publish them to GitHub OCI registry."""

    def __init__(self, package_dir: str, dist_dir: str, tmp_dir: str, github_token: Optional[str] = None):
        """Initialize the PEX builder.

        Args:
            package_dir: Directory containing the package configuration
            dist_dir: Directory to store the built PEX files
            tmp_dir: Directory for temporary files
            github_token: GitHub token for authentication
        """
        self.package_dir = Path(package_dir)
        self.dist_dir = Path(dist_dir)
        self.tmp_dir = Path(tmp_dir)
        self.github_token = github_token or os.environ.get("GITHUB_TOKEN")
        
        if not self.github_token:
            print("Warning: GITHUB_TOKEN not set. OCI registry uploads may fail.")
        
        # Create directories if they don't exist
        self.dist_dir.mkdir(parents=True, exist_ok=True)
        self.tmp_dir.mkdir(parents=True, exist_ok=True)

    def load_config(self, package_name: str) -> Dict:
        """Load the package configuration from config.yaml.
        
        Args:
            package_name: Name of the package
            
        Returns:
            Dict containing the package configuration
        """
        config_path = self.package_dir / package_name / "config.yaml"
        if not config_path.exists():
            raise FileNotFoundError(f"Config file not found: {config_path}")
        
        with open(config_path, "r") as f:
            config = yaml.safe_load(f)
            
        # If package name is not specified in config, use directory name
        if "package" not in config:
            config["package"] = package_name
        
        # Sort versions by semver if they exist
        if "versions" in config:
            config["versions"] = sorted(config["versions"], key=lambda v: semver.VersionInfo.parse(v["version"]))
            
        return config

    def get_pypi_versions(self, package_name: str, min_version: str) -> List[str]:
        """Get all versions of a package from PyPI starting with min_version.
        
        Args:
            package_name: Name of the package
            min_version: Minimum version to include
            
        Returns:
            List of versions sorted by semver
        """
        url = f"https://pypi.org/pypi/{package_name}/json"
        response = requests.get(url)
        response.raise_for_status()
        
        data = response.json()
        all_versions = list(data["releases"].keys())
        
        # Filter versions that are >= min_version
        valid_versions = []
        for version in all_versions:
            try:
                if semver.compare(version, min_version) >= 0:
                    valid_versions.append(version)
            except ValueError:
                # Skip versions that don't follow semver
                continue
                
        # Sort versions
        valid_versions.sort(key=lambda v: semver.VersionInfo.parse(v))
        return valid_versions

    def create_dependency_files(self, package_name: str, version: str, python_version: str) -> Path:
        """Create dependency files (requirements.in and requirements.txt) for the specified package version.
        
        Args:
            package_name: Name of the package
            version: Version of the package
            python_version: Python version to use
            
        Returns:
            Path to the directory containing the dependency files
        """
        # Create directory structure for this version
        version_dir = self.package_dir / package_name / version
        version_dir.mkdir(parents=True, exist_ok=True)
        
        # Create requirements.in file
        req_in_file = version_dir / "requirements.in"
        with open(req_in_file, "w") as f:
            f.write(f"{package_name}=={version}\n")
        
        # Create requirements.txt (lock file)
        req_txt_file = version_dir / "requirements.txt"
        
        # Skip if lock file already exists
        if req_txt_file.exists():
            print(f"Lock file already exists: {req_txt_file}")
            return version_dir
        
        print(f"Creating lock file for {package_name}=={version} with Python {python_version}")

        try:
            # Use uv to create a lock file
            cmd = [
                "uv", "pip", "compile", 
                "--output-file", str(req_txt_file),
                str(req_in_file),
                "--python-version", str(python_version)
            ]

            print(f"Running command: {' '.join(cmd)}")
            subprocess.run(cmd, check=True, capture_output=True)
            print(f"Successfully ceated lock file: {req_txt_file}")
            return version_dir

        except subprocess.CalledProcessError as e:
            if hasattr(e, 'stderr') and e.stderr:
                print(f"Failed to create lock file with uv: {e.stderr.decode()}")
            else:
                print(f"Failed to create lock file with uv: {e}")
            # raise
    
    def build_pex(self, package_name: str, version: str, python_version: str) -> Path:
        """Build a PEX file for the specified package version.
        
        Args:
            package_name: Name of the package
            version: Version of the package
            python_version: Python version to use
            
        Returns:
            Path to the built PEX file
        """
        # Get OS and architecture information
        os_name = platform.system().lower()
        if os_name == "darwin":
            os_name = "macos"
        
        # Get architecture
        arch = platform.machine().lower()
        if arch == "x86_64":
            arch = "amd64"
        elif arch == "aarch64" or arch == "arm64":
            arch = "arm64"
            
        # Create PEX filename with OS and architecture
        pex_filename = f"{package_name}-{os_name}-{arch}.pex"
        pex_path = self.dist_dir / "python" / package_name / str(version) / pex_filename

        # Skip if PEX file already exists
        if pex_path.exists():
            print(f"PEX file already exists: {pex_path}")
            return pex_path
        
        print(f"Building PEX for {package_name}=={version} with Python {python_version}")
        
        # First create dependency files
        version_dir = self.create_dependency_files(package_name, version, python_version)
        req_txt_file = version_dir / "requirements.txt"

        # Run uv tool to create PEX file
        cmd = [
            "uv",
            "tool",
            "run",
            "--python",
            str(python_version),
            "--isolated",
            "--managed-python",
            "--from",
            "pex==2.37.0",
            "pex",
            "-r", str(req_txt_file),
            "-o", str(pex_path),
            "--compression-level", "9",  # Maximum compression
            "--compress-abi", "True",
            "--compress", "True",
        ]
            
        try:
            print(f"Running command: {' '.join(cmd)}")
            subprocess.run(cmd, check=True, capture_output=True)
            print(f"Successfully built PEX: {pex_path}")
            return pex_path
        except subprocess.CalledProcessError as e:
            print(f"Failed to build PEX: {e.stderr.decode()}")
            raise

    def create_binary_scripts(self, pex_path: Path, package_name: str, binaries: List[str]) -> List[Path]:
        """Create bash scripts for each binary that invoke the PEX file.
        
        Args:
            pex_path: Path to the PEX file
            package_name: Name of the package
            binaries: List of binary names to create scripts for
            
        Returns:
            List of paths to the created binary scripts
        """
        # Get the directory where the PEX file is located
        pex_dir = pex_path.parent
        script_paths = []
        
        for binary in binaries:
            script_path = pex_dir / binary
            
            # Create the bash script
            with open(script_path, "w") as f:
                f.write(f"""#!/bin/bash
# Auto-generated script for {binary}
# Executes the PEX file looking for the entry point with the same name

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${{BASH_SOURCE[0]}}" )" && pwd )"

# Execute the PEX file with the PEX_SCRIPT environment variable
PEX_SCRIPT={binary} exec "$SCRIPT_DIR/{pex_path.name}" "$@"
""")
            
            # Make the script executable
            os.chmod(script_path, 0o755)
            print(f"Created binary script: {script_path}")
            script_paths.append(script_path)
            
        return script_paths

    def process_package(self, package_name: str) -> None:
        """Process a package: build PEX files and update Hermit manifest.
        
        Args:
            package_name: Name of the package
        """
        config = self.load_config(package_name)
        actual_package_name = config['package']
        versions_config = config['versions']
        binaries = config['binaries']
        
        if not versions_config:
            raise ValueError(f"No versions specified for {package_name}")
        
        # Sort versions by semver and get the lowest version
        sorted_versions = sorted(versions_config, key=lambda v: semver.VersionInfo.parse(v["version"]))
        min_version = sorted_versions[0]["version"]
        
        # Get all versions from PyPI
        all_versions = self.get_pypi_versions(actual_package_name, min_version)
        print(f"Found {len(all_versions)} versions for {actual_package_name} >= {min_version}")

        # Map Python versions to package versions
        version_map = {}
        for version_info in versions_config:
            version = version_info["version"]
            python_version = version_info["python"]
            
            # Find all versions >= this version but < next specified version
            next_version = None
            for v in versions_config:
                if semver.compare(v["version"], version) > 0:
                    if next_version is None or semver.compare(v["version"], next_version) < 0:
                        next_version = v["version"]
            
            # Filter versions
            for v in all_versions:
                if semver.compare(v, version) >= 0 and (next_version is None or semver.compare(v, next_version) < 0):
                    version_map[v] = python_version

        # Build PEX files for each version
        for version, python_version in version_map.items():
            try:
                # Create dependency files first
                self.create_dependency_files(actual_package_name, version, python_version)
                
                # Build PEX file
                pex_path = self.build_pex(actual_package_name, version, python_version)
                
                # Create binary scripts
                script_paths = self.create_binary_scripts(pex_path, actual_package_name, binaries)

            except Exception as e:
                print(f"Error processing {actual_package_name} {version}: {e}")


def main():
    """Main entry point."""
    parser = argparse.ArgumentParser(description="Build PEX packages and publish to GitHub OCI registry")
    parser.add_argument("package", help="Package directory name (under python/)")
    parser.add_argument("--dist-dir", default=os.environ.get("DIST_DIR", "dist"),
                        help="Directory to store built PEX files")
    parser.add_argument("--tmp-dir", default=os.environ.get("TMP_DIR", "tmp"),
                        help="Directory for temporary files")
    parser.add_argument("--github-token", help="GitHub token for authentication")
    
    args = parser.parse_args()
    
    package_dir = Path("python")
    if not package_dir.exists():
        print(f"Package directory not found: {package_dir}")
        sys.exit(1)
    
    builder = PexBuilder(
        package_dir=package_dir,
        dist_dir=args.dist_dir,
        tmp_dir=args.tmp_dir,
        github_token=args.github_token
    )
    
    # try:
    builder.process_package(args.package)
    # except Exception as e:
    #     print(f"Error: {e}")
    #     sys.exit(1)


if __name__ == "__main__":
    main()
