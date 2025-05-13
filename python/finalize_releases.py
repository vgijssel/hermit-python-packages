#!/usr/bin/env python3
"""
Finalize GitHub releases by checking if all required assets are present.
"""

import argparse
import os
import sys
from pathlib import Path
from typing import Dict, List, Optional, Set

import yaml
from github import Github, GithubException


class ReleaseManager:
    """Manage GitHub releases for Python packages."""

    def __init__(self, package_dir: str, github_repo: str, github_token: Optional[str] = None):
        """Initialize the release manager.

        Args:
            package_dir: Directory containing the package configurations
            github_repo: GitHub repository name (owner/repo)
            github_token: GitHub token for authentication
        """
        self.package_dir = Path(package_dir)
        self.github_repo = github_repo
        
        # Try to get GitHub token from multiple sources
        self.github_token = github_token
        if not self.github_token:
            self.github_token = os.environ.get("GITHUB_TOKEN")
        
        # Print debug info about token (without revealing it)
        if self.github_token:
            print(f"GitHub token found with length: {len(self.github_token)}")
        else:
            print("Error: GITHUB_TOKEN not set. GitHub API operations will fail.")
            sys.exit(1)
        
        # Initialize GitHub client
        try:
            self.github = Github(self.github_token)
            # Test the connection
            user = self.github.get_user()
            print(f"Authenticated as: {user.login}")
            self.repo = self.github.get_repo(self.github_repo)
            print(f"Connected to repository: {self.github_repo}")
        except Exception as e:
            print(f"Error connecting to GitHub: {e}")
            sys.exit(1)

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
            return {}
        
        with open(config_path, "r") as f:
            config = yaml.safe_load(f)
            
        # If package name is not specified in config, use directory name
        if "package" not in config:
            config["package"] = package_name
            
        return config

    def get_prerelease_releases(self, package_name: str = None) -> List[Dict]:
        """Get all prerelease releases for a package or all packages.
        
        Args:
            package_name: Name of the package, or None for all packages
            
        Returns:
            List of release data dictionaries
        """
        prerelease_releases = []
        
        try:
            # Get all releases for the repository
            all_releases = self.repo.get_releases()
            
            # Filter prerelease releases
            for release in all_releases:
                if not release.prerelease:
                    continue
                
                # If package_name is specified, filter by package name
                if package_name:
                    if not release.tag_name.startswith(f"{package_name}-v"):
                        continue
                
                # Extract package name and version from tag name
                tag_parts = release.tag_name.split("-v")
                if len(tag_parts) != 2:
                    continue
                
                pkg_name = tag_parts[0]
                version = tag_parts[1]
                
                # Get assets
                assets = [asset.name for asset in release.get_assets()]
                
                prerelease_releases.append({
                    "release": release,
                    "package_name": pkg_name,
                    "version": version,
                    "assets": assets
                })
            
            return prerelease_releases
        except Exception as e:
            print(f"Error getting prerelease releases: {e}")
            return []

    def check_and_finalize_release(self, release_data: Dict) -> bool:
        """Check if all required assets are present and finalize the release.
        
        Args:
            release_data: Dictionary containing release data
            
        Returns:
            True if the release was finalized, False otherwise
        """
        release = release_data["release"]
        package_name = release_data["package_name"]
        assets = release_data["assets"]
        
        # Expected assets for required platforms
        expected_assets = [
            f"{package_name}-darwin-arm64.tar.gz",
            f"{package_name}-darwin-amd64.tar.gz",
            f"{package_name}-linux-arm64.tar.gz",
            f"{package_name}-linux-amd64.tar.gz"
        ]
        
        # Check if all expected assets are present
        missing_assets = [asset for asset in expected_assets if asset not in assets]
        
        if missing_assets:
            print(f"Release {release.tag_name} is missing assets: {missing_assets}")
            print(f"Release will remain in prerelease mode until all assets are uploaded.")
            return False
        
        # All assets are present, finalize the release
        print(f"All platform assets are present for {release.tag_name}, finalizing release.")
        try:
            release.update_release(
                name=release.title,
                message=release.body,
                draft=False,
                prerelease=False  # Remove prerelease status
            )
            print(f"Release {release.tag_name} has been finalized: {release.html_url}")
            return True
        except Exception as e:
            print(f"Error finalizing release {release.tag_name}: {e}")
            return False

    def finalize_releases(self, package_name: str = None) -> bool:
        """Finalize all prerelease releases for a package or all packages.
        
        Args:
            package_name: Name of the package, or None for all packages
            
        Returns:
            True if all releases were finalized successfully, False otherwise
        """
        success = True
        
        # Get all releases
        all_releases = list(self.repo.get_releases())
        print(f"Total releases found: {len(all_releases)}")
        
        # Get prerelease releases
        prerelease_releases = self.get_prerelease_releases(package_name)
        
        # Count regular (non-prerelease) releases for this package
        regular_releases = [r for r in all_releases if not r.prerelease and 
                           (not package_name or r.tag_name.startswith(f"{package_name}-v"))]
        
        print(f"Regular releases found{' for ' + package_name if package_name else ''}: {len(regular_releases)}")
        
        if not prerelease_releases:
            print(f"No prerelease releases found{' for ' + package_name if package_name else ''}.")
            return True
        
        print(f"Found {len(prerelease_releases)} prerelease releases{' for ' + package_name if package_name else ''}.")
        
        # Check and finalize each release
        for release_data in prerelease_releases:
            if not self.check_and_finalize_release(release_data):
                success = False
                
        return success


def main():
    """Main entry point."""
    parser = argparse.ArgumentParser(description="Finalize GitHub releases")
    parser.add_argument("package", help="Package directory name (under python/)")
    parser.add_argument("--github-token", help="GitHub token for authentication")
    parser.add_argument("--github-repo", default="vgijssel/hermit-python-packages",
                        help="GitHub repository name (owner/repo)")
    
    args = parser.parse_args()
    
    package_dir = Path("python")
    if not package_dir.exists():
        print(f"Error: Package directory not found: {package_dir}")
        sys.exit(1)
    
    try:
        # Try to get token from environment first
        github_token = args.github_token or os.environ.get("GITHUB_TOKEN")
        if not github_token:
            print("Warning: No GitHub token provided via --github-token or GITHUB_TOKEN environment variable")
        
        manager = ReleaseManager(
            package_dir=package_dir,
            github_token=github_token,
            github_repo=args.github_repo
        )
        
        success = manager.finalize_releases(args.package)
        if not success:
            print("Error: Failed to finalize one or more releases")
            sys.exit(1)
            
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
