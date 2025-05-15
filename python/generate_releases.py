#!/usr/bin/env python3
"""
Generate GitHub releases for Python packages based on state.yaml files.
"""

import argparse
import os
import sys
import logging
from pathlib import Path
from typing import Dict, Optional, Tuple, List
import yaml
from github import Github, GithubException


class ReleaseGenerator:
    """Generate GitHub releases for Python packages based on state.yaml files."""

    def __init__(self, package_dir: str, github_repo: str, github_token: Optional[str] = None):
        """Initialize the release generator.

        Args:
            package_dir: Directory containing the package configurations
            github_repo: GitHub repository name (owner/repo)
            github_token: GitHub token for authentication
        """
        self.package_dir = Path(package_dir)
        self.github_repo = github_repo
        self.github_token = github_token or os.environ.get("GITHUB_TOKEN")
        self.logger = logging.getLogger('release_generator')
        
        # Hard failure if GitHub token is missing
        if not self.github_token:
            self.logger.error("GITHUB_TOKEN not set. GitHub API operations will fail.")
            sys.exit(1)
        
        # Initialize GitHub client
        self.github = Github(self.github_token)
        self.logger.info(f"ReleaseGenerator initialized for repo: {github_repo}")

    def load_config(self, package_name: str) -> Dict:
        """Load the package configuration from config.yaml.
        
        Args:
            package_name: Name of the package
            
        Returns:
            Dict containing the package configuration
        """
        config_path = self.package_dir / package_name / "config.yaml"
        if not config_path.exists():
            print(f"Error: Config file not found: {config_path}")
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
            print(f"Error: State file not found: {state_path}")
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

    def delete_github_release(self, package_name: str, version: str) -> bool:
        """Delete a GitHub release for the given package and version.
        
        Args:
            package_name: Name of the package
            version: Version of the package
            
        Returns:
            bool: True if successful, False otherwise
        """
        try:
            # Format the tag name
            tag_name = f"{package_name}-v{version}"
            
            # Get the repository
            repo = self.github.get_repo(self.github_repo)
            
            try:
                # Get the release
                release = repo.get_release(tag_name)
                
                # Delete the release
                release.delete_release()
                self.logger.info(f"Successfully deleted release: {tag_name}")
                
                # Delete the tag
                try:
                    ref = repo.get_git_ref(f"tags/{tag_name}")
                    ref.delete()
                    self.logger.info(f"Successfully deleted tag: {tag_name}")
                except GithubException as e:
                    self.logger.warning(f"Could not delete tag {tag_name}: {e}")
                
                return True
            except GithubException as e:
                self.logger.warning(f"Release {tag_name} not found: {e}")
                return True  # Consider it a success if the release doesn't exist
                
        except Exception as e:
            self.logger.error(f"Error deleting GitHub release: {e}", exc_info=True)
            return False

    def create_github_release(self, package_name: str, version: str) -> Tuple[bool, Optional[object]]:
        """Create a GitHub release for the given package and version.
        
        Args:
            package_name: Name of the package
            version: Version of the package
            
        Returns:
            Tuple of (success, release_object)
            - success: True if successful, False otherwise
            - release_object: The release object if successful, None otherwise
        """
        try:
            # Format the tag name and release name
            tag_name = f"{package_name}-v{version}"
            release_name = tag_name
            
            # Get the repository
            repo = self.github.get_repo(self.github_repo)
            
            # Check if release already exists
            self.logger.info(f"Creating GitHub release: {release_name} (prerelease mode)")
            release = repo.create_git_release(
                tag=tag_name,
                name=release_name,
                message='',
                draft=False,
                prerelease=True  # Create in prerelease mode
            )
            self.logger.info(f"Successfully created release: {tag_name}")
            return True, release
                
        except Exception as e:
            self.logger.error(f"Error creating GitHub release: {e}", exc_info=True)
            return False, None

    def process_package(self, package_name: str) -> bool:
        """Process a package: create GitHub releases for versions that need them.
        
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

            state = self.load_state(package_name)
            versions = state.get('versions', [])
            
            if not versions:
                self.logger.info(f"No versions found in state file for {package_name}")
                return True
            
            has_changes = False
            for version_info in versions:
                version = version_info['version']
                has_requirements = version_info['requirements']
                has_release = version_info['release']
                release_info = version_info.get('release_info', {})

                build_info = {
                    "config_version": config_version,
                    "python": version_info['python'],
                    "version": version,
                    "binaries": config['binaries'],
                }
                
                self.logger.debug(f"Processing {actual_package_name} {version}: requirements={has_requirements}, release={has_release}")
                
                # Check if release exists but doesn't have release_info
                if has_release and (not release_info or not release_info.get('build_info')):
                    self.logger.info(f"Release exists without release_info, recreating release for {actual_package_name} {version}")
                    
                    # Delete existing release
                    self.delete_github_release(actual_package_name, version)
                    
                    # Reset release state
                    version_info['release'] = False
                    version_info['assets'] = {}
                    version_info['release_info'] = {}
                    has_changes = True
                    
                    # Create new release
                    success, _ = self.create_github_release(actual_package_name, version)
                    if success:
                        version_info['release'] = True
                    else:
                        self.logger.error(f"Failed to recreate release for {actual_package_name} {version}")
                        return False
                
                # Check if build_info in release_info matches config_version
                elif has_release and release_info and 'build_info' in release_info:
                    release_build_info = release_info['build_info']

                    if build_info != release_build_info:
                        self.logger.info(f"Config version changed from {release_build_info} to {build_info}, recreating release for {actual_package_name} {version}")
                        
                        # Delete existing release
                        self.delete_github_release(actual_package_name, version)
                        
                        # Reset release state
                        version_info['release'] = False
                        version_info['assets'] = {}
                        version_info['release_info'] = {}
                        has_changes = True
                        
                        # Create new release
                        success, _ = self.create_github_release(actual_package_name, version)
                        if success:
                            version_info['release'] = True
                        else:
                            self.logger.error(f"Failed to recreate release for {actual_package_name} {version}")
                            return False
                
                # Only create releases for versions with requirements but no release
                elif has_requirements and not has_release:
                    self.logger.info(f"Creating release for {actual_package_name} {version}")
                    success, _ = self.create_github_release(actual_package_name, version)
                    if success:
                        version_info['release'] = True
                        has_changes = True
                    else:
                        self.logger.error(f"Failed to create release for {actual_package_name} {version}")
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
    parser = argparse.ArgumentParser(description="Generate GitHub releases for Python packages")
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
    logger = logging.getLogger('release_generator')
    
    package_dir = Path("python")
    if not package_dir.exists():
        logger.error(f"Package directory not found: {package_dir}")
        sys.exit(1)
    
    try:
        generator = ReleaseGenerator(
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
