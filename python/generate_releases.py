#!/usr/bin/env python3
"""
Generate GitHub releases for Python packages based on state.yaml files.
"""

import argparse
import os
import sys
from pathlib import Path
from typing import Dict, Optional, Tuple
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
        
        # Hard failure if GitHub token is missing
        if not self.github_token:
            print("Error: GITHUB_TOKEN not set. GitHub API operations will fail.")
            sys.exit(1)
        
        # Initialize GitHub client
        self.github = Github(self.github_token)

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
        
        print(f"State saved to {state_path}")

    def check_requirements_exist(self, package_name: str, version: str) -> bool:
        """Check if requirements files exist for the given package and version.
        
        Args:
            package_name: Name of the package
            version: Version of the package
            
        Returns:
            True if both requirements.in and requirements.txt exist, False otherwise
        """
        version_dir = self.package_dir / package_name / version
        req_in_file = version_dir / "requirements.in"
        req_txt_file = version_dir / "requirements.txt"
        
        return req_in_file.exists() and req_txt_file.exists()

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
            release_name = f"{package_name} v{version}"
            
            # Get the repository
            repo = self.github.get_repo(self.github_repo)
            
            # Check if release already exists
            try:
                release = repo.get_release(tag_name)
                print(f"Release {tag_name} already exists.")
                return True, release
            except GithubException:
                # Create the release in prerelease mode
                print(f"Creating GitHub release: {release_name} (prerelease mode)")
                release_message = f"Release of {package_name} version {version}"
                release = repo.create_git_release(
                    tag=tag_name,
                    name=release_name,
                    message=release_message,
                    draft=False,
                    prerelease=True  # Create in prerelease mode
                )
                return True, release
                
        except Exception as e:
            print(f"Error creating GitHub release: {e}")
            return False, None

    def process_package(self, package_name: str) -> bool:
        """Process a package: create GitHub releases for versions that need them.
        
        Args:
            package_name: Name of the package
            
        Returns:
            bool: True if successful, False if any errors occurred
        """
        try:
            config = self.load_config(package_name)
            actual_package_name = config['package']
            
            state = self.load_state(package_name)
            versions = state.get('versions', [])
            
            if not versions:
                print(f"No versions found in state file for {package_name}")
                return True
            
            has_changes = False
            for version_info in versions:
                version = version_info['version']
                has_requirements = version_info.get('requirements', False)
                has_release = version_info.get('release', False)
                
                # Only create releases for versions with requirements but no release
                if has_requirements and not has_release:
                    # Double-check that requirements files actually exist
                    if not self.check_requirements_exist(package_name, version):
                        print(f"Warning: Requirements files not found for {actual_package_name} {version}")
                        continue
                    
                    print(f"Creating release for {actual_package_name} {version}")
                    success, _ = self.create_github_release(actual_package_name, version)
                    if success:
                        version_info['release'] = True
                        has_changes = True
                    else:
                        print(f"Failed to create release for {actual_package_name} {version}")
                        return False
            
            # Save state if there were changes
            if has_changes:
                self.save_state(package_name, state)
                
            return True
        except Exception as e:
            print(f"Error processing package {package_name}: {e}")
            return False


def main():
    """Main entry point."""
    parser = argparse.ArgumentParser(description="Generate GitHub releases for Python packages")
    parser.add_argument("package", nargs='+', help="Package directory name(s) (under python/)")
    parser.add_argument("--github-token", help="GitHub token for authentication")
    parser.add_argument("--github-repo", default="vgijssel/hermit-python-packages",
                        help="GitHub repository name (owner/repo)")
    
    args = parser.parse_args()
    
    package_dir = Path("python")
    if not package_dir.exists():
        print(f"Error: Package directory not found: {package_dir}")
        sys.exit(1)
    
    try:
        generator = ReleaseGenerator(
            package_dir=package_dir,
            github_token=args.github_token,
            github_repo=args.github_repo
        )
        
        success = True
        for package in args.package:
            print(f"Processing package: {package}")
            if not generator.process_package(package):
                print(f"Error: Failed to process package {package}")
                success = False
        
        if not success:
            sys.exit(1)
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
