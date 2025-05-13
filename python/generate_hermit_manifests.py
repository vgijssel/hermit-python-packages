#!/usr/bin/env python3
"""
Generate Hermit manifests based on GitHub releases and config.yaml files.
"""

import argparse
import hashlib
import json
import os
import sys
from pathlib import Path
from typing import Dict, List, Optional, Set

import requests
import yaml
from github import Github, GithubException


class HermitManifestGenerator:
    """Generate Hermit manifests based on GitHub releases and config.yaml files."""

    def __init__(self, package_dir: str, github_repo: str, github_token: Optional[str] = None):
        """Initialize the Hermit manifest generator.

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
        self.repo = self.github.get_repo(self.github_repo)

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

    def get_github_releases(self, package_name: str) -> Dict[str, Dict]:
        """Get all GitHub releases for a package.
        
        Args:
            package_name: Name of the package
            
        Returns:
            Dict mapping version to release data
        """
        releases = {}
        
        try:
            # Get all releases for the repository
            all_releases = self.repo.get_releases()
            
            # Filter releases for this package
            for release in all_releases:
                # Skip prereleases
                if release.prerelease:
                    continue
                
                # Check if the tag name starts with the package name
                tag_name = release.tag_name
                if tag_name.startswith(f"{package_name}-v"):
                    # Extract version from tag name
                    version = tag_name.replace(f"{package_name}-v", "")
                    
                    # Get assets
                    assets = {}
                    for asset in release.get_assets():
                        assets[asset.name] = {
                            "url": asset.browser_download_url,
                            "size": asset.size,
                        }
                    
                    releases[version] = {
                        "tag_name": tag_name,
                        "name": release.title,
                        "url": release.html_url,
                        "assets": assets,
                    }
            
            return releases
        except Exception as e:
            print(f"Error getting GitHub releases for {package_name}: {e}")
            return {}

    def calculate_sha256(self, url: str) -> str:
        """Calculate SHA256 hash of a file from URL.
        
        Args:
            url: URL of the file
            
        Returns:
            SHA256 hash as a hex string
        """
        try:
            response = requests.get(url, stream=True)
            response.raise_for_status()
            
            sha256_hash = hashlib.sha256()
            for chunk in response.iter_content(chunk_size=4096):
                sha256_hash.update(chunk)
                
            return sha256_hash.hexdigest()
        except Exception as e:
            print(f"Error calculating SHA256 for {url}: {e}")
            return ""

    def generate_manifest(self, package_name: str) -> bool:
        """Generate a Hermit manifest for a package.
        
        Args:
            package_name: Name of the package
            
        Returns:
            True if successful, False otherwise
        """
        try:
            # Load package configuration
            config = self.load_config(package_name)
            if not config:
                return False
                
            actual_package_name = config.get("package", package_name)
            binaries = config.get("binaries", [])
            test_command = config.get("test", "")
            description = config.get("description", f"Python tool {actual_package_name} packaged as PEX")
            
            # Get GitHub releases
            releases = self.get_github_releases(actual_package_name)
            if not releases:
                print(f"No releases found for {actual_package_name}")
                return False
                
            # Get Python version mapping from config
            python_versions = {}
            for version_info in config.get("versions", []):
                version = version_info.get("version")
                python_version = version_info.get("python")
                if version and python_version:
                    python_versions[version] = python_version
            
            # Generate manifest content
            manifest_content = f'description = "{description}"\n'
            manifest_content += f'binaries = {json.dumps(binaries)}\n'
            if test_command:
                manifest_content += f'test = "{test_command}"\n'
            manifest_content += f'repository = "https://github.com/{self.github_repo}"\n\n'
            
            # Add platform-specific source sections
            manifest_content += 'darwin {\n'
            manifest_content += f'  source = "https://github.com/{self.github_repo}/releases/download/{actual_package_name}-v${{version}}/{actual_package_name}-${{os}}-${{arch}}.tar.gz"\n'
            manifest_content += '}\n\n'
            
            # Add version sections
            sha256sums = {}
            for version, release_data in releases.items():
                # Add version section
                manifest_content += f'version "{version}" {{\n'
                
                # Add runtime dependencies
                python_version = python_versions.get(version)
                if python_version:
                    manifest_content += f'  runtime-dependencies = ["python3@{python_version}"]\n'
                
                manifest_content += '}\n\n'
                
                # Calculate SHA256 sums for assets
                assets = release_data.get("assets", {})
                for asset_name, asset_data in assets.items():
                    if asset_name.endswith(".tar.gz") and (
                        "darwin-arm64" in asset_name or 
                        "darwin-amd64" in asset_name
                    ):
                        url = asset_data.get("url")
                        if url:
                            sha256 = self.calculate_sha256(url)
                            if sha256:
                                sha256sums[url] = sha256
            
            # Add SHA256 sums
            if sha256sums:
                manifest_content += "sha256sums = {\n"
                for url, sha256 in sha256sums.items():
                    manifest_content += f'  "{url}": "{sha256}",\n'
                manifest_content += "}\n"
            
            # Write manifest file
            manifest_path = Path(f"{actual_package_name}.hcl")
            with open(manifest_path, "w") as f:
                f.write(manifest_content)
                
            print(f"Generated manifest: {manifest_path}")
            return True
            
        except Exception as e:
            print(f"Error generating manifest for {package_name}: {e}")
            return False

    def generate_all_manifests(self) -> bool:
        """Generate Hermit manifests for all packages.
        
        Returns:
            True if all manifests were generated successfully, False otherwise
        """
        success = True
        
        # Get all package directories
        package_dirs = [d for d in self.package_dir.iterdir() if d.is_dir()]
        
        for package_dir in package_dirs:
            package_name = package_dir.name
            if not self.generate_manifest(package_name):
                success = False
                
        return success


def main():
    """Main entry point."""
    parser = argparse.ArgumentParser(description="Generate Hermit manifests")
    parser.add_argument("--package", help="Package name (if not specified, generate for all packages)")
    parser.add_argument("--package-dir", default="python", help="Directory containing package configurations")
    parser.add_argument("--github-token", help="GitHub token for authentication")
    parser.add_argument("--github-repo", default="vgijssel/hermit-python-packages",
                        help="GitHub repository name (owner/repo)")
    
    args = parser.parse_args()
    
    package_dir = Path(args.package_dir)
    if not package_dir.exists():
        print(f"Error: Package directory not found: {package_dir}")
        sys.exit(1)
    
    try:
        generator = HermitManifestGenerator(
            package_dir=args.package_dir,
            github_token=args.github_token,
            github_repo=args.github_repo
        )
        
        if args.package:
            success = generator.generate_manifest(args.package)
        else:
            success = generator.generate_all_manifests()
            
        if not success:
            print("Error: Failed to generate one or more manifests")
            sys.exit(1)
            
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
