#!/usr/bin/env python3
"""
Build PEX packages for Python tools and publish them to GitHub OCI registry.
"""

import argparse
import json
import os
import re
import subprocess
import sys
import tempfile
from pathlib import Path
from typing import Dict, List, Optional, Tuple

import requests
import semver
import yaml
import venv


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
        
        # Use a virtual environment to create a lock file
        try:
            venv_dir = self.tmp_dir / f"venv-{package_name}-{version}-py{python_version}"
            
            # Create virtual environment
            print(f"Creating virtual environment for {package_name}=={version} with Python {python_version}")
            
            # Use the current Python to create a venv
            cmd = [
                sys.executable, "-m", "venv", str(venv_dir)
            ]
            subprocess.run(cmd, check=True, capture_output=True)
            
            # Determine pip and python paths in the venv
            if sys.platform == "win32":
                pip_path = venv_dir / "Scripts" / "pip"
                python_path = venv_dir / "Scripts" / "python"
            else:
                pip_path = venv_dir / "bin" / "pip"
                python_path = venv_dir / "bin" / "python"
            
            # Install pip-tools in the venv
            cmd = [
                str(pip_path), "install", "pip-tools"
            ]
            subprocess.run(cmd, check=True, capture_output=True)
            
            # Use pip-compile to create a lock file
            cmd = [
                str(pip_path), "install", "pip-compile"
            ]
            subprocess.run(cmd, check=True, capture_output=True)
            
            cmd = [
                str(python_path), "-m", "piptools", "compile",
                "--output-file", str(req_txt_file),
                str(req_in_file)
            ]
            subprocess.run(cmd, check=True, capture_output=True)
            print(f"Successfully created lock file: {req_txt_file}")
            return version_dir
        except subprocess.CalledProcessError as e:
            if hasattr(e, 'stderr') and e.stderr:
                print(f"Failed to create lock file: {e.stderr.decode()}")
            else:
                print(f"Failed to create lock file: {e}")
            # Create an empty lock file to avoid repeated failures
            with open(req_txt_file, "w") as f:
                f.write(f"# Failed to generate lock file for {package_name}=={version}\n")
                f.write(f"{package_name}=={version}\n")
            return version_dir
    
    def build_pex(self, package_name: str, version: str, python_version: str) -> Path:
        """Build a PEX file for the specified package version.
        
        Args:
            package_name: Name of the package
            version: Version of the package
            python_version: Python version to use
            
        Returns:
            Path to the built PEX file
        """
        pex_filename = f"{package_name}-{version}-py{python_version}.pex"
        pex_path = self.dist_dir / pex_filename
        
        # Skip if PEX file already exists
        if pex_path.exists():
            print(f"PEX file already exists: {pex_path}")
            return pex_path
        
        print(f"Building PEX for {package_name}=={version} with Python {python_version}")
        
        # First create dependency files
        version_dir = self.create_dependency_files(package_name, version, python_version)
        req_txt_file = version_dir / "requirements.txt"
        
        # Create a temporary directory for building
        with tempfile.TemporaryDirectory(dir=self.tmp_dir) as temp_dir:
            temp_dir_path = Path(temp_dir)
            
            # Build PEX file using the lock file and the current Python interpreter
            cmd = [
                "pex",
                "-r", str(req_txt_file),
                "-o", str(pex_path),
                "--python-shebang", f"/usr/bin/env python",
                "-c", package_name,  # Use package name as entry point
                "--disable-cache",
                "--no-pypi",
                "--pip-version", "latest"
            ]
            
            try:
                subprocess.run(cmd, check=True, capture_output=True)
                print(f"Successfully built PEX: {pex_path}")
                return pex_path
            except subprocess.CalledProcessError as e:
                print(f"Failed to build PEX: {e.stderr.decode()}")
                raise

    def upload_to_oci(self, pex_path: Path, package_name: str, version: str, 
                     python_version: str, platform: str = "linux") -> str:
        """Upload a PEX file to GitHub OCI registry.
        
        Args:
            pex_path: Path to the PEX file
            package_name: Name of the package
            version: Version of the package
            python_version: Python version used
            platform: Platform (linux or darwin)
            
        Returns:
            OCI reference to the uploaded blob
        """
        # GitHub OCI registry URL
        registry = "ghcr.io"
        repo_owner = os.environ.get("GITHUB_REPOSITORY_OWNER", "hermit-python-packages")
        image_name = f"{registry}/{repo_owner}/{package_name}"
        tag = f"{version}-py{python_version}-{platform}"
        
        print(f"Uploading {pex_path} to {image_name}:{tag}")
        
        # Use Docker to push the PEX file as a single-layer image
        with tempfile.TemporaryDirectory(dir=self.tmp_dir) as temp_dir:
            temp_dir_path = Path(temp_dir)
            
            # Create a Dockerfile
            dockerfile = temp_dir_path / "Dockerfile"
            with open(dockerfile, "w") as f:
                f.write(f"FROM scratch\n")
                f.write(f"COPY {pex_path.name} /app/{package_name}\n")
                f.write(f"CMD [\"/app/{package_name}\"]\n")
            
            # Copy PEX file to temp dir
            subprocess.run(["cp", str(pex_path), temp_dir], check=True)
            
            # Build and push Docker image
            image_ref = f"{image_name}:{tag}"
            
            # Login to GitHub Container Registry
            if self.github_token:
                login_cmd = [
                    "docker", "login", registry,
                    "-u", repo_owner,
                    "--password-stdin"
                ]
                login_proc = subprocess.Popen(login_cmd, stdin=subprocess.PIPE)
                login_proc.communicate(input=self.github_token.encode())
                if login_proc.returncode != 0:
                    raise RuntimeError("Failed to login to GitHub Container Registry")
            
            # Build image
            build_cmd = [
                "docker", "build",
                "-t", image_ref,
                "-f", str(dockerfile),
                str(temp_dir_path)
            ]
            subprocess.run(build_cmd, check=True)
            
            # Push image
            push_cmd = ["docker", "push", image_ref]
            subprocess.run(push_cmd, check=True)
            
            # Get image digest
            inspect_cmd = [
                "docker", "inspect",
                "--format", "{{index .RepoDigests 0}}",
                image_ref
            ]
            result = subprocess.run(inspect_cmd, check=True, capture_output=True, text=True)
            digest = result.stdout.strip()
            
            print(f"Uploaded to {digest}")
            return digest

    def update_hermit_manifest(self, package_name: str, versions: List[Dict]) -> None:
        """Update the Hermit manifest file for the package.
        
        Args:
            package_name: Name of the package
            versions: List of version configurations
        """
        manifest_path = Path("hermit") / f"{package_name}.hcl"
        
        # Create basic manifest structure
        manifest = f"""description = "Python tool {package_name} packaged as PEX"
binaries = ["{package_name}"]
test = "{package_name} --help"
repository = "https://github.com/hermit-python-packages/hermit-python-packages"
source-repo = "https://github.com/paul-gauthier/aider"

darwin {{
  source = "oci://ghcr.io/hermit-python-packages/{package_name}:${{version}}-${{python-version}}-darwin"
}}

linux {{
  source = "oci://ghcr.io/hermit-python-packages/{package_name}:${{version}}-${{python-version}}-linux"
}}

on "unpack" {{
  rename {{
    from = "${{root}}/app/{package_name}"
    to = "${{root}}/{package_name}"
  }}
  
  chmod {{
    file = "${{root}}/{package_name}"
    mode = 493  # 0755 in octal
  }}
}}

"""
        
        # Add version blocks
        for version_info in versions:
            version = version_info["version"]
            python_version = version_info["python"]
            
            manifest += f"""version "{version}" {{
  python-version = "py{python_version}"
}}

"""
        
        # Write manifest file
        with open(manifest_path, "w") as f:
            f.write(manifest)
            
        print(f"Updated Hermit manifest: {manifest_path}")

    def process_package(self, package_name: str) -> None:
        """Process a package: build PEX files and update Hermit manifest.
        
        Args:
            package_name: Name of the package
        """
        config = self.load_config(package_name)
        actual_package_name = config.get("package", package_name)
        versions_config = config.get("versions", [])
        
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
        built_versions = []
        for version, python_version in version_map.items():
            try:
                # Create dependency files first
                self.create_dependency_files(actual_package_name, version, python_version)
                
                # Build PEX file
                pex_path = self.build_pex(actual_package_name, version, python_version)
                
                # # Upload to OCI registry
                # for platform in ["linux", "darwin"]:
                #     self.upload_to_oci(pex_path, actual_package_name, version, python_version, platform)
                
                # built_versions.append({
                #     "version": version,
                #     "python": python_version
                # })
            except Exception as e:
                print(f"Error processing {actual_package_name} {version}: {e}")
        
        # Update Hermit manifest
        # self.update_hermit_manifest(actual_package_name, built_versions)


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
    
    try:
        builder.process_package(args.package)
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
