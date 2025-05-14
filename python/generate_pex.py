#!/usr/bin/env python3
"""
Generate PEX files for Python packages based on state.yaml files.
"""

import argparse
import hashlib
import os
import platform
import subprocess
import sys
import tarfile
import tempfile
import logging
from pathlib import Path
from typing import Dict, List, Optional, Tuple
import shutil
import yaml
from github import Github, GithubException


class PexGenerator:
    """Generate PEX files for Python packages based on state.yaml files."""

    def __init__(self, package_dir: str, dist_dir: str, tmp_dir: str, github_repo: str, github_token: Optional[str] = None):
        """Initialize the PEX generator.

        Args:
            package_dir: Directory containing the package configurations
            dist_dir: Directory to store the built PEX files
            tmp_dir: Directory for temporary files
            github_repo: GitHub repository name (owner/repo)
            github_token: GitHub token for authentication
        """
        self.package_dir = Path(package_dir)
        self.dist_dir = Path(dist_dir)
        self.tmp_dir = Path(tmp_dir)
        self.github_repo = github_repo
        self.github_token = github_token or os.environ.get("GITHUB_TOKEN")
        self.logger = logging.getLogger('pex_generator')
        
        # Hard failure if GitHub token is missing
        if not self.github_token:
            self.logger.error("GITHUB_TOKEN not set. GitHub API operations will fail.")
            sys.exit(1)
        
        # Create directories if they don't exist
        self.dist_dir.mkdir(parents=True, exist_ok=True)
        self.tmp_dir.mkdir(parents=True, exist_ok=True)

        # Get OS and architecture information
        os_name = platform.system().lower()
        self.os_name = os_name
        
        # Get architecture
        arch_name = platform.machine().lower()
        if arch_name == "x86_64":
            arch_name = "amd64"
        elif arch_name == "aarch64" or arch_name == "arm64":
            arch_name = "arm64"

        self.arch_name = arch_name
        self.logger.info(f"Platform detected: {self.os_name}-{self.arch_name}")
        
        # Initialize GitHub client
        self.github = Github(self.github_token)
        self.logger.info(f"PexGenerator initialized for repo: {github_repo}")

    def load_config(self, package_name: str) -> Dict:
        """Load the package configuration from config.yaml.
        
        Args:
            package_name: Name of the package
            
        Returns:
            Dict containing the package configuration
        """
        config_path = self.package_dir / package_name / "config.yaml"
        if not config_path.exists():
            self.logger.error(f"Config file not found: {config_path}")
            sys.exit(1)
        
        with open(config_path, "r") as f:
            config = yaml.safe_load(f)
            
        # If package name is not specified in config, use directory name
        if "package" not in config:
            config["package"] = package_name
            
        return config

    def load_state(self, package_name: str) -> Dict:
        """Load the package state from state.yaml.
        
        Args:
            package_name: Name of the package
            
        Returns:
            Dict containing the package state
        """
        state_path = self.package_dir / package_name / "state.yaml"
        if not state_path.exists():
            self.logger.error(f"State file not found: {state_path}")
            sys.exit(1)
        
        with open(state_path, "r") as f:
            state = yaml.safe_load(f)
            
        return state

    def save_state(self, package_name: str, state: Dict) -> None:
        """Save state to a YAML file.
        
        Args:
            package_name: Name of the package
            state: State to save
        """
        state_path = self.package_dir / package_name / "state.yaml"
        with open(state_path, "w") as f:
            yaml.dump(state, f, default_flow_style=False)
        
        self.logger.info(f"State saved to {state_path}")

    def build_pex(self, package_name: str, version: str, python_version: str) -> Path:
        """Build a PEX file for the specified package version.
        
        Args:
            package_name: Name of the package
            version: Version of the package
            python_version: Python version to use
            
        Returns:
            Path to the built PEX file
        """
        pex_filename = f"{package_name}.pex"
        pex_path = self.dist_dir / "python" / str(python_version) / package_name / str(version) / pex_filename

        # Skip if PEX file already exists
        if pex_path.exists():
            self.logger.info(f"PEX file already exists: {pex_path}")
            return pex_path
        
        self.logger.info(f"Building PEX for {package_name}=={version} with Python {python_version}")
        
        # Check if requirements files exist
        version_dir = self.package_dir / package_name / version
        req_txt_file = version_dir / "requirements.txt"
        
        if not req_txt_file.exists():
            self.logger.error(f"Requirements file not found: {req_txt_file}")
            sys.exit(1)

        # Ensure the output directory exists
        pex_path.parent.mkdir(parents=True, exist_ok=True)

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
        ]
            
        try:
            self.logger.debug(f"Running command: {' '.join(cmd)}")
            subprocess.run(cmd, check=True, capture_output=True)
            self.logger.info(f"Successfully built PEX: {pex_path}")
            return pex_path
        except subprocess.CalledProcessError as e:
            if hasattr(e, 'stderr') and e.stderr:
                self.logger.error(f"Failed to build PEX: {e.stderr.decode()}")
            else:
                self.logger.error(f"Failed to build PEX: {e}")
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
            # Include OS and architecture in the binary script name
            script_name = binary
            script_path = pex_dir / script_name
            
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
            self.logger.info(f"Created binary script: {script_path}")
            script_paths.append(script_path)
            
        return script_paths

    def create_tarball(self, package_name: str, pex_path: Path, script_paths: List[Path]) -> Tuple[Path, str]:
        """Create a tarball containing the PEX file and binary scripts.
        
        Args:
            package_name: Name of the package
            pex_path: Path to the PEX file
            script_paths: List of paths to binary scripts
            
        Returns:
            Tuple of (path to the created tarball, SHA256 hash of the tarball)
        """
        # Create tarball filename with OS and architecture
        tarball_filename = f"{package_name}-{self.os_name}-{self.arch_name}.tar.gz"
        tarball_path = pex_path.parent / tarball_filename
        
        # Create a temporary directory to stage files
        with tempfile.TemporaryDirectory() as temp_dir:
            temp_dir_path = Path(temp_dir)
            
            # Copy PEX file to temp directory
            shutil.copy2(pex_path, temp_dir_path / pex_path.name)
            
            # Copy binary scripts to temp directory
            for script_path in script_paths:
                shutil.copy2(script_path, temp_dir_path / script_path.name)
            
            # Create tarball
            with tarfile.open(tarball_path, "w:gz") as tar:
                for file_path in os.listdir(temp_dir):
                    tar.add(os.path.join(temp_dir, file_path), arcname=file_path)
            
            self.logger.info(f"Created tarball: {tarball_path}")
            
            # Calculate SHA256 hash of the tarball
            sha256_hash = hashlib.sha256()
            with open(tarball_path, "rb") as f:
                for chunk in iter(lambda: f.read(4096), b""):
                    sha256_hash.update(chunk)
            
            tarball_hash = sha256_hash.hexdigest()
            self.logger.debug(f"SHA256 hash: {tarball_hash}")
            
            return tarball_path, tarball_hash

    def upload_to_github_release(self, package_name: str, version: str, tarball_path: Path, tarball_hash: str) -> bool:
        """Upload the tarball to a GitHub release.
        
        Args:
            package_name: Name of the package
            version: Version of the package
            tarball_path: Path to the tarball
            tarball_hash: SHA256 hash of the tarball
            
        Returns:
            bool: True if successful, False otherwise
        """
        try:
            # Format the tag name
            tag_name = f"{package_name}-v{version}"
            
            # Get the repository
            repo = self.github.get_repo(self.github_repo)
            
            # Get the release
            try:
                release = repo.get_release(tag_name)
            except GithubException:
                self.logger.error(f"Release {tag_name} not found")
                return False
            
            # Check if asset already exists
            asset_name = tarball_path.name
            for asset in release.get_assets():
                if asset.name == asset_name:
                    self.logger.info(f"Asset {asset_name} already exists, deleting it")
                    asset.delete_asset()
                    break
            
            # Check if hash file already exists
            hash_file_name = f"{asset_name.rsplit('.', 1)[0]}.sha256"
            for asset in release.get_assets():
                if asset.name == hash_file_name:
                    self.logger.info(f"Asset {hash_file_name} already exists, deleting it")
                    asset.delete_asset()
                    break
            
            self.logger.info(f"Uploading tarball: {tarball_path}")
            release.upload_asset(
                path=str(tarball_path),
                name=asset_name,
                content_type="application/gzip"
            )
            
            # Create and upload SHA256 file
            with tempfile.NamedTemporaryFile(mode='w', delete=False, suffix='.sha256') as temp_file:
                temp_file.write(f"{tarball_hash}  {asset_name}\n")
                temp_file_path = temp_file.name
            
            self.logger.info(f"Uploading SHA256 hash file: {hash_file_name}")
            release.upload_asset(
                path=temp_file_path,
                name=hash_file_name,
                content_type="text/plain"
            )
            
            # Clean up temporary file
            os.unlink(temp_file_path)
            
            self.logger.info(f"Successfully uploaded tarball and hash to release: {release.html_url}")
            return True
            
        except Exception as e:
            self.logger.error(f"Error uploading to GitHub release: {e}", exc_info=True)
            return False

    def process_package(self, package_name: str) -> bool:
        """Process a package: build PEX files and upload to GitHub releases.
        
        Args:
            package_name: Name of the package
            
        Returns:
            bool: True if successful, False if any errors occurred
        """
        try:
            self.logger.info(f"Starting to process package: {package_name}")
            config = self.load_config(package_name)
            actual_package_name = config['package']
            binaries = config.get('binaries', [])
            
            if not binaries:
                self.logger.error(f"No binaries specified for {package_name}")
                return False
            
            state = self.load_state(package_name)
            versions = state.get('versions', [])
            
            if not versions:
                self.logger.info(f"No versions found in state file for {package_name}")
                return True
            
            has_changes = False
            for version_info in versions:
                version = version_info['version']
                python_version = version_info['python']
                has_requirements = version_info.get('requirements', False)
                has_release = version_info.get('release', False)
                assets = version_info.get('assets', {})
                
                self.logger.debug(f"Processing {actual_package_name} {version}: requirements={has_requirements}, release={has_release}")
                
                # Only process versions with requirements and releases
                if has_requirements and has_release:
                    # Check if we need to build for this platform
                    asset_name = f"{actual_package_name}-{self.os_name}-{self.arch_name}.tar.gz"
                    if asset_name in assets:
                        self.logger.info(f"Asset {asset_name} already exists for {actual_package_name} {version}, skipping")
                        continue
                    
                    try:
                        # Build PEX file
                        pex_path = self.build_pex(actual_package_name, version, python_version)
                        
                        # Create binary scripts
                        script_paths = self.create_binary_scripts(pex_path, actual_package_name, binaries)
                        
                        # Create tarball and calculate hash
                        tarball_path, tarball_hash = self.create_tarball(actual_package_name, pex_path, script_paths)
                        
                        # Upload to GitHub release
                        success = self.upload_to_github_release(actual_package_name, version, tarball_path, tarball_hash)
                        if success:
                            # Update state with the new asset
                            version_info['assets'][asset_name] = tarball_hash
                            has_changes = True
                        else:
                            self.logger.error(f"Failed to upload {asset_name} for {actual_package_name} {version}")
                            
                    except Exception as e:
                        self.logger.error(f"Error processing {actual_package_name} {version}: {e}", exc_info=True)
                        return False
            
            # Save state if there were changes
            if has_changes:
                self.save_state(package_name, state)
                
            self.logger.info(f"Successfully processed package: {package_name}")
            return True
        except Exception as e:
            self.logger.error(f"Error processing package {package_name}: {e}", exc_info=True)
            return False


def main():
    """Main entry point."""
    parser = argparse.ArgumentParser(description="Generate PEX files for Python packages")
    parser.add_argument("package", nargs='+', help="Package directory name(s) (under python/)")
    parser.add_argument("--dist-dir", default=os.environ.get("DIST_DIR", "dist"),
                        help="Directory to store built PEX files")
    parser.add_argument("--tmp-dir", default=os.environ.get("TMP_DIR", "tmp"),
                        help="Directory for temporary files")
    parser.add_argument("--github-token", help="GitHub token for authentication")
    parser.add_argument("--github-repo", default="vgijssel/hermit-python-packages",
                        help="GitHub repository name (owner/repo)")
    parser.add_argument("--log-level", default="INFO", 
                        choices=["DEBUG", "INFO", "WARNING", "ERROR", "CRITICAL"],
                        help="Set the logging level")
    
    args = parser.parse_args()
    
    # Configure logging
    logging.basicConfig(
        level=getattr(logging, args.log_level),
        format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
        datefmt='%Y-%m-%d %H:%M:%S'
    )
    logger = logging.getLogger('pex_generator')
    
    package_dir = Path("python")
    if not package_dir.exists():
        logger.error(f"Package directory not found: {package_dir}")
        sys.exit(1)
    
    try:
        generator = PexGenerator(
            package_dir=package_dir,
            dist_dir=args.dist_dir,
            tmp_dir=args.tmp_dir,
            github_token=args.github_token,
            github_repo=args.github_repo
        )
        
        success = True
        for package in args.package:
            logger.info(f"Processing package: {package}")
            if not generator.process_package(package):
                logger.error(f"Failed to process package {package}")
                success = False
        
        if not success:
            sys.exit(1)
    except Exception as e:
        logger.error(f"Error: {e}", exc_info=True)
        sys.exit(1)


if __name__ == "__main__":
    main()
