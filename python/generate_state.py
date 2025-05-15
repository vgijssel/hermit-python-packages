#!/usr/bin/env python3
"""
Generate state files for Python packages based on config.yaml files.
"""

import argparse
import os
import sys
import hashlib
import logging
from pathlib import Path
from typing import Dict, List, Optional, Any
import yaml
import requests
import semver
import re
from github import Github, GithubException


class StateGenerator:
    """Generate state files for Python packages based on config.yaml files."""

    def __init__(self, package_dir: str, github_repo: str, github_token: Optional[str] = None):
        """Initialize the state generator.

        Args:
            package_dir: Directory containing the package configurations
            github_repo: GitHub repository name (owner/repo)
            github_token: GitHub token for authentication
        """
        self.package_dir = Path(package_dir)
        self.github_repo = github_repo
        self.github_token = github_token or os.environ.get("GITHUB_TOKEN")
        self.logger = logging.getLogger('state_generator')
        
        # Hard failure if GitHub token is missing
        if not self.github_token:
            self.logger.error("GITHUB_TOKEN not set. GitHub API operations will fail.")
            sys.exit(1)
        
        # Initialize GitHub client
        self.github = Github(self.github_token)
        self.logger.info(f"StateGenerator initialized for repo: {github_repo}")
        
        # Cache all GitHub releases
        self.github_releases = {}
        self.github_release_assets = {}
        self._cache_github_releases()

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

    def _cache_github_releases(self):
        """Cache all GitHub releases to avoid multiple API calls."""
        try:
            self.logger.info(f"Caching all GitHub releases from {self.github_repo}")
            repo = self.github.get_repo(self.github_repo)
            releases = repo.get_releases()
            
            for release in releases:
                tag_name = release.tag_name
                build_info = self._extract_build_info_from_description(release.body)

                self.github_releases[tag_name] = {
                    "exists": True,
                    "is_prerelease": release.prerelease,
                    "build_info": build_info,
                }

                # Extract build information from release description
                assets = {}
                
                if build_info and "assets" in build_info:
                    for asset_name, sha256 in build_info["assets"].items():
                        assets[asset_name] = sha256
                
                self.github_release_assets[tag_name] = assets
                
            self.logger.info(f"Cached {len(self.github_releases)} GitHub releases")
        except Exception as e:
            self.logger.error(f"Error caching GitHub releases: {e}", exc_info=True)
            sys.exit(1)

    def _extract_build_info_from_description(self, description: str) -> Optional[Dict]:
        """Extract build information from a GitHub release description.
        
        Args:
            description: GitHub release description
            
        Returns:
            Dict containing build information or None if not found
        """
        if not description:
            return None
            
        # Look for YAML block in the description
        yaml_match = re.search(r'```yaml\n(.*?)```', description, re.DOTALL)
        if not yaml_match:
            return None
            
        yaml_content = yaml_match.group(1)
        try:
            build_info = yaml.safe_load(yaml_content)
            return build_info
        except Exception as e:
            self.logger.error(f"Error parsing build info YAML: {e}")
            return None

    def check_github_release(self, package_name: str, version: str) -> Dict:
        """Check if a GitHub release exists for the given package and version.
        
        Args:
            package_name: Name of the package
            version: Version of the package
            
        Returns:
            Dict containing release information
        """
        tag_name = f"{package_name}-v{version}"
        
        # Check if release exists in cache
        if tag_name in self.github_releases:
            return {
                "exists": True,
                "is_prerelease": self.github_releases[tag_name]["is_prerelease"],
                "assets": self.github_release_assets.get(tag_name, {}),
                "build_info": self.github_releases[tag_name]["build_info"],
            }
            self.logger.debug(f"Found release {tag_name} in cache")
        else:
            return {
                "exists": False,
                "is_prerelease": False,
                "assets": {},
                "build_info": {},
            }


    def generate_state(self, package_name: str) -> Dict:
        """Generate state for a package.
        
        Args:
            package_name: Name of the package
            
        Returns:
            Dict containing the state
        """
        config = self.load_config(package_name)
        actual_package_name = config['package']
        versions_config = config.get('versions', [])
        config_version = config.get('config_version', 1)
        
        if not versions_config:
            print(f"Error: No versions specified for {package_name}")
            sys.exit(1)
        
        # Sort versions by semver and get the lowest version
        sorted_versions = sorted(versions_config, key=lambda v: semver.VersionInfo.parse(v["version"]))
        min_version = sorted_versions[0]["version"]
        
        # Get all versions from PyPI
        all_versions = self.get_pypi_versions(actual_package_name, min_version)
        self.logger.info(f"Found {len(all_versions)} versions for {actual_package_name} >= {min_version}")

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

        # Generate state for each version
        state = {
            "config_version": config_version,
            "versions": []
        }
        for version, python_version in version_map.items():
            self.logger.info(f"Processing {actual_package_name} version {version} with Python {python_version}")
            
            # Check if requirements files exist
            has_requirements = self.check_requirements_exist(package_name, version)
            self.logger.debug(f"{actual_package_name} v{version}: requirements exist = {has_requirements}")
            
            # Check if GitHub release exists
            release_info = self.check_github_release(actual_package_name, version)
            self.logger.debug(f"{actual_package_name} v{version}: release exists = {release_info['exists']}")
            
            # Add to state
            state["versions"].append({
                "version": version,
                "python": python_version,
                "requirements": has_requirements,
                "release": release_info["exists"],
                "assets": release_info["assets"],
                "build_info": release_info["build_info"],
            })
        
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

    def process_package(self, package_name: str) -> bool:
        """Process a package: generate and save state.
        
        Args:
            package_name: Name of the package
            
        Returns:
            bool: True if successful, False if any errors occurred
        """
        try:
            self.logger.info(f"Starting to process package: {package_name}")
            state = self.generate_state(package_name)
            self.save_state(package_name, state)
            self.logger.info(f"Successfully processed package: {package_name}")
            return True
        except Exception as e:
            self.logger.error(f"Error processing package {package_name}: {e}", exc_info=True)
            return False


def main():
    """Main entry point."""
    parser = argparse.ArgumentParser(description="Generate state files for Python packages")
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
    logger = logging.getLogger('state_generator')
    
    package_dir = Path("python")
    if not package_dir.exists():
        print(f"Error: Package directory not found: {package_dir}")
        sys.exit(1)
    
    try:
        generator = StateGenerator(
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
