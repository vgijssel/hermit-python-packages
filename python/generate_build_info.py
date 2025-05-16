#!/usr/bin/env python3
"""
Generate build information for Python packages and update GitHub release descriptions.
"""

import argparse
import os
import sys
import logging
import re
import glob
from pathlib import Path
from typing import Dict, Optional, List
import yaml
from github import Github, GithubException


class BuildInfoGenerator:
    """Generate build information for Python packages and update GitHub release descriptions."""

    def __init__(self, package_dir: str, github_repo: str, github_token: Optional[str] = None):
        """Initialize the build info generator.

        Args:
            package_dir: Directory containing the package configurations
            github_repo: GitHub repository name (owner/repo)
            github_token: GitHub token for authentication
        """
        self.package_dir = Path(package_dir)
        self.github_repo = github_repo
        self.github_token = github_token or os.environ.get("GITHUB_TOKEN")
        self.logger = logging.getLogger('build_info_generator')
        
        # Hard failure if GitHub token is missing
        if not self.github_token:
            self.logger.error("GITHUB_TOKEN not set. GitHub API operations will fail.")
            sys.exit(1)
        
        # Initialize GitHub client
        self.github = Github(self.github_token)
        self.logger.info(f"BuildInfoGenerator initialized for repo: {github_repo}")

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
        """Load the package state from state.yaml or merge platform-specific asset files.
        
        Args:
            package_name: Name of the package
            
        Returns:
            Dict containing the package state
        """
        state_path = self.package_dir / package_name / "state.yaml"
        
        # Check for platform-specific asset files
        asset_pattern = str(self.package_dir / package_name / "asset-*.yaml")
        asset_files = glob.glob(asset_pattern)
        
        if asset_files:
            self.logger.info(f"Found {len(asset_files)} platform-specific asset files for {package_name}")
            
            # Load and merge all asset files
            merged_state = None
            for asset_file in asset_files:
                self.logger.debug(f"Loading asset file: {asset_file}")
                with open(asset_file, "r") as f:
                    asset_state = yaml.safe_load(f)
                
                if merged_state is None:
                    merged_state = asset_state
                else:
                    # Merge versions and their assets
                    asset_versions = {v['version']: v for v in asset_state.get('versions', [])}
                    
                    for i, version_info in enumerate(merged_state.get('versions', [])):
                        version = version_info['version']
                        if version in asset_versions:
                            # Merge assets from this platform
                            if 'assets' not in merged_state['versions'][i]:
                                merged_state['versions'][i]['assets'] = {}
                                
                            if 'assets' in asset_versions[version]:
                                merged_state['versions'][i]['assets'].update(asset_versions[version]['assets'])
            
            # Save the merged state to state.yaml
            with open(state_path, "w") as f:
                yaml.dump(merged_state, f, default_flow_style=False)
            
            self.logger.info(f"Merged platform-specific assets into {state_path}")
            return merged_state
        
        # Fall back to state.yaml if no asset files found
        if not state_path.exists():
            self.logger.error(f"State file not found: {state_path}")
            sys.exit(1)
        
        with open(state_path, "r") as f:
            state = yaml.safe_load(f)
            
        return state

    def check_version_complete(self, package_assets: Dict, package_name: str, version: str) -> bool:
        """Check if a version has all required platform assets.
        
        Args:
            package_assets: Package assets information
            package_name: Name of the package
            version: Version of the package

        Returns:
            bool: True if all required platforms have assets, False otherwise
        """
        required_assets = [
            f"{package_name}-linux-amd64.tar.gz",
            f"{package_name}-linux-arm64.tar.gz",
            f"{package_name}-darwin-amd64.tar.gz",
            f"{package_name}-darwin-arm64.tar.gz"
        ]
        result = True

        for required_asset in required_assets:
            # Check if the asset exists for this platform
            if required_asset in package_assets:
                self.logger.debug(f"Found required asset {required_asset} for version {version}")
            else:
                self.logger.debug(f"Missing required asset {required_asset} for version {version}")
                result = False
        
        return result

    def update_github_release_description(self, package_name: str, version: str, python_version: str, assets: Dict, config_version: int, binaries: List[str], state_build_info: Optional[Dict] = None) -> bool:
        """Update the GitHub release description with build information.
        
        Args:
            package_name: Name of the package
            version: Version of the package
            python_version: Python version used for the build
            assets: Dictionary of asset names and their SHA256 hashes
            config_version: Configuration version
            binaries: List of binary names
            state_build_info: Build information from state file, if available
            
        Returns:
            bool: True if successful, False otherwise
        """
        try:
            # Format the tag name
            tag_name = f"{package_name}-v{version}"
            
            # Create build information YAML
            build_info = {
                "package": package_name,
                "config_version": config_version,
                "python": python_version,
                "version": version,
                "binaries": binaries
            }
            
            asset_info = {}
            for asset_name, asset_hash in assets.items():
                asset_info[asset_name] = asset_hash
            
            release_info = {
                "build_info": build_info,
                "asset_info": asset_info
            }
            
            if state_build_info and state_build_info.get("build_info") == build_info:
                # Check if asset_info is the same
                if state_build_info.get("asset_info") == asset_info:
                    self.logger.info(f"Build information for {tag_name} in state file matches new build info, skipping update")
                    return True
                else:
                    self.logger.info(f"Asset information for {tag_name} has changed, updating release description")
            
            # Get the repository
            repo = self.github.get_repo(self.github_repo)
            
            try:
                release = repo.get_release(tag_name)
            except GithubException:
                self.logger.error(f"Release {tag_name} not found")
                return False
            
            # Convert to YAML string
            release_info_yaml = yaml.dump(release_info, default_flow_style=False)

            is_prerelease = not self.check_version_complete(asset_info, package_name, version)

            # Update release description
            release.update_release(
                name=release.title,
                message=f"```yaml\n{release_info_yaml}```",
                prerelease=is_prerelease
            )
            
            self.logger.info(f"Updated release description for {tag_name}")
            return True
            
        except Exception as e:
            self.logger.error(f"Error updating GitHub release description: {e}", exc_info=True)
            return False

    def process_package(self, package_name: str) -> bool:
        """Process a package: update GitHub release descriptions with build information.
        
        Args:
            package_name: Name of the package
            
        Returns:
            bool: True if successful, False if any errors occurred
        """
        try:
            self.logger.info(f"Starting to process package: {package_name}")
            config = self.load_config(package_name)
            actual_package_name = config['package']
            config_version = config.get('config_version', 1)
            binaries = config.get('binaries', [])
            
            state = self.load_state(package_name)
            versions = state.get('versions', [])
            
            if not versions:
                self.logger.info(f"No versions found in state file for {package_name}")
                return True
            
            for version_info in versions:
                version = version_info['version']
                python_version = version_info['python']
                has_release = version_info.get('release', False)
                assets = version_info.get('assets', {})
                release_info = version_info.get('release_info', {})
                
                # Only process versions with releases and assets
                if has_release and assets:
                    # Extract asset hashes
                    asset_hashes = {}
                    for asset_name, asset_hash in assets.items():
                        if asset_hash:  # Only include assets with hashes
                            asset_hashes[asset_name] = asset_hash
                    
                    if asset_hashes:
                        # Update GitHub release description
                        success = self.update_github_release_description(
                            actual_package_name, version, python_version, asset_hashes, 
                            config_version, binaries, release_info
                        )
                        if not success:
                            self.logger.error(f"Failed to update release description for {actual_package_name} {version}")
            
            self.logger.info(f"Successfully processed package: {package_name}")
            return True
        except Exception as e:
            self.logger.error(f"Error processing package {package_name}: {e}", exc_info=True)
            return False


def main():
    """Main entry point."""
    parser = argparse.ArgumentParser(description="Generate build information for Python packages")
    parser.add_argument("package", nargs='+', help="Package directory name(s) (under python/)")
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
    logger = logging.getLogger('build_info_generator')
    
    package_dir = Path("python")
    if not package_dir.exists():
        logger.error(f"Package directory not found: {package_dir}")
        sys.exit(1)
    
    try:
        generator = BuildInfoGenerator(
            package_dir=package_dir,
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
