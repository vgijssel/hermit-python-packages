#!/usr/bin/env python3
"""
Generate Hermit manifest files for Python packages based on state.yaml files.
"""

import argparse
import os
import sys
from pathlib import Path
from typing import Dict, List, Set, Optional
import yaml


class HermitManifestGenerator:
    """Generate Hermit manifest files for Python packages based on state.yaml files."""

    def __init__(self, package_dir: str):
        """Initialize the Hermit manifest generator.

        Args:
            package_dir: Directory containing the package configurations
        """
        self.package_dir = Path(package_dir)
        self.repo_root = Path.cwd()

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

    def get_required_platforms(self) -> List[str]:
        """Get the list of required platforms for a complete release.
        
        Returns:
            List of platform strings (e.g., "linux-amd64", "darwin-arm64")
        """
        return [
            "linux-amd64",
            "linux-arm64",
            "darwin-amd64",
            "darwin-arm64"
        ]

    def check_version_complete(self, version_info: Dict) -> bool:
        """Check if a version has all required platform assets.
        
        Args:
            version_info: Version information from state.yaml
            
        Returns:
            bool: True if all required platforms have assets, False otherwise
        """
        assets = version_info.get('assets', {})
        required_platforms = self.get_required_platforms()
        
        for platform in required_platforms:
            # Check if the asset exists for this platform
            asset_name_parts = platform.split('-')
            os_name = asset_name_parts[0]
            arch_name = asset_name_parts[1]
            
            asset_name = f"{version_info['package']}-{os_name}-{arch_name}.tar.gz"
            if asset_name not in assets:
                return False
        
        return True

    def generate_manifest(self, package_name: str) -> bool:
        """Generate a Hermit manifest file for the package.
        
        Args:
            package_name: Name of the package
            
        Returns:
            bool: True if successful, False otherwise
        """
        try:
            config = self.load_config(package_name)
            actual_package_name = config['package']
            description = config.get('description', f"{actual_package_name} package")
            test = config.get('test', '')
            binaries = config.get('binaries', [])
            
            if not binaries:
                print(f"Error: No binaries specified for {package_name}")
                return False
            
            state = self.load_state(package_name)
            versions = state.get('versions', [])
            
            if not versions:
                print(f"No versions found in state file for {package_name}")
                return False
            
            # Filter versions that have all required platform assets
            complete_versions = []
            sha256sums = {}
            
            for version_info in versions:
                version = version_info['version']
                assets = version_info.get('assets', {})
                
                # Add package name to version_info for check_version_complete
                version_info['package'] = actual_package_name
                
                if self.check_version_complete(version_info):
                    complete_versions.append(version)
                    
                    # Add SHA256 sums for all assets
                    for asset_name, sha256 in assets.items():
                        url = f"https://github.com/vgijssel/hermit-python-packages/releases/download/{actual_package_name}-v{version}/{asset_name}"
                        sha256sums[url] = sha256
            
            if not complete_versions:
                print(f"No complete versions found for {package_name}")
                return False
            
            # Sort versions
            complete_versions.sort(reverse=True)
            
            # Generate manifest content
            manifest_content = f'description = "{description}"\n'
            manifest_content += f'binaries = {str(binaries).replace("\'", "\"")}\n'
            if test:
                manifest_content += f'test = "{test}"\n'
            manifest_content += 'repository = "https://github.com/vgijssel/hermit-python-packages"\n'
            manifest_content += 'source = "https://github.com/vgijssel/hermit-python-packages/releases/download/'
            manifest_content += f'{actual_package_name}-v${{version}}/{actual_package_name}-${{os}}-${{arch}}.tar.gz"\n\n'
            
            # Add version blocks
            for version in complete_versions:
                manifest_content += f'version "{version}" {{\n}}\n\n'
            
            # Add SHA256 sums
            manifest_content += 'sha256sums = {\n'
            for url, sha256 in sorted(sha256sums.items()):
                manifest_content += f'  "{url}": "{sha256}",\n'
            manifest_content += '}\n'
            
            # Write manifest file
            manifest_path = self.repo_root / f"{actual_package_name}.hcl"
            with open(manifest_path, "w") as f:
                f.write(manifest_content)
            
            print(f"Generated Hermit manifest: {manifest_path}")
            return True
            
        except Exception as e:
            print(f"Error generating manifest for {package_name}: {e}")
            return False

    def process_package(self, package_name: str) -> bool:
        """Process a package: generate Hermit manifest.
        
        Args:
            package_name: Name of the package
            
        Returns:
            bool: True if successful, False if any errors occurred
        """
        return self.generate_manifest(package_name)


def main():
    """Main entry point."""
    parser = argparse.ArgumentParser(description="Generate Hermit manifest files for Python packages")
    parser.add_argument("package", nargs='+', help="Package directory name(s) (under python/)")
    
    args = parser.parse_args()
    
    package_dir = Path("python")
    if not package_dir.exists():
        print(f"Error: Package directory not found: {package_dir}")
        sys.exit(1)
    
    try:
        generator = HermitManifestGenerator(package_dir=package_dir)
        
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
