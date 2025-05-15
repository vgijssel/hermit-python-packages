#!/usr/bin/env python3
"""
Generate Hermit manifest files for Python packages based on state.yaml files.
"""

import argparse
import os
import sys
import logging
from pathlib import Path
from typing import Dict, List, Set, Optional
import yaml
from jinja2 import Template


class HermitManifestGenerator:
    """Generate Hermit manifest files for Python packages based on state.yaml files."""

    def __init__(self, package_dir: str):
        """Initialize the Hermit manifest generator.

        Args:
            package_dir: Directory containing the package configurations
        """
        self.package_dir = Path(package_dir)
        self.repo_root = Path.cwd()
        self.logger = logging.getLogger('hermit_manifest_generator')

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

    def check_version_complete(self, version_info: Dict) -> bool:
        """Check if a version has all required platform assets.
        
        Args:
            version_info: Version information from state.yaml
            
        Returns:
            bool: True if all required platforms have assets, False otherwise
        """
        package_assets = version_info.get('assets', {})
        required_assets = [
            # f"{version_info['package']}-linux-amd64.tar.gz",
            # f"{version_info['package']}-linux-arm64.tar.gz",
            # f"{version_info['package']}-darwin-amd64.tar.gz",
            f"{version_info['package']}-darwin-arm64.tar.gz"
        ]
        result = True

        for required_asset in required_assets:
            # Check if the asset exists for this platform
            if required_asset in package_assets:
                self.logger.debug(f"Found required asset {required_asset} for version {version_info['version']}")
            else:
                self.logger.debug(f"Missing required asset {required_asset} for version {version_info['version']}")
                result = False
        
        return result

    def _get_manifest_template(self) -> Template:
        """Get the Jinja2 template for the Hermit manifest."""
        template_str = """description = "{{ description }}"
binaries = {{ binaries | tojson }}
{% if test %}test = "{{ test }}"
{% endif %}repository = "https://github.com/vgijssel/hermit-python-packages"
source = "https://github.com/vgijssel/hermit-python-packages/releases/download/{{ package_name }}-v${version}/{{ package_name }}-${os}-${arch}.tar.gz"

{% for version_info in versions %}version "{{ version_info['version'] }}" {
  runtime-dependencies = ["python3@{{ version_info['python'] }}"]
}
{% endfor %}
sha256sums = {
{% for url, sha256 in sha256sums %}  "{{ url }}": "{{ sha256 }}",
{% endfor %}}
"""
        return Template(template_str)

    def generate_manifest(self, package_name: str) -> bool:
        """Generate a Hermit manifest file for the package.
        
        Args:
            package_name: Name of the package
            
        Returns:
            bool: True if successful, False otherwise
        """
        try:
            self.logger.info(f"Generating manifest for package: {package_name}")
            config = self.load_config(package_name)
            actual_package_name = config['package']
            description = config.get('description', f"{actual_package_name} package")
            test = config.get('test', '')
            binaries = config.get('binaries', [])
            
            if not binaries:
                self.logger.error(f"No binaries specified for {package_name}")
                return False
            
            state = self.load_state(package_name)
            versions = state.get('versions', [])
            
            if not versions:
                self.logger.info(f"No versions found in state file for {package_name}")
                return False
            
            # Filter versions that have all required platform assets
            complete_versions = []
            sha256sums = {}
            
            for version_info in versions:
                version = version_info['version']
                python_version = version_info['python']
                assets = version_info.get('assets', {})

                self.logger.debug(f"Processing {actual_package_name} {version}: assets={assets} python_version={python_version}")
                
                # Add package name to version_info for check_version_complete
                version_info['package'] = actual_package_name
                
                self.logger.debug(f"Checking completeness of version {version}")
                if self.check_version_complete(version_info):
                    self.logger.info(f"Version {version} is complete with all required assets")
                    complete_versions.append(version_info)
                    
                    # Add SHA256 sums for all assets
                    for asset_name, sha256 in assets.items():
                        url = f"https://github.com/vgijssel/hermit-python-packages/releases/download/{actual_package_name}-v{version}/{asset_name}"
                        sha256sums[url] = sha256
                        self.logger.debug(f"Added SHA256 for {asset_name}: {sha256}")
            
            if not complete_versions:
                self.logger.warning(f"No complete versions found for {package_name}")
                return False
            
            # sort complete versions by version key inside the dict
            complete_versions = sorted(complete_versions, key=lambda x: x['version'], reverse=True)

            self.logger.info(f"Found {len(complete_versions)} complete versions: {', '.join([v['version'] for v in complete_versions])}")

            # Generate manifest content using Jinja2 template
            template = self._get_manifest_template()
            manifest_content = template.render(
                description=description,
                binaries=binaries,
                test=test,
                package_name=actual_package_name,
                versions=complete_versions,
                sha256sums=sorted(sha256sums.items())
            )
            
            # Write manifest file
            manifest_path = self.repo_root / f"{actual_package_name}.hcl"
            with open(manifest_path, "w") as f:
                f.write(manifest_content)
            
            self.logger.info(f"Generated Hermit manifest: {manifest_path}")
            return True
            
        except Exception as e:
            self.logger.error(f"Error generating manifest for {package_name}: {e}", exc_info=True)
            return False

    def process_package(self, package_name: str) -> bool:
        """Process a package: generate Hermit manifest.
        
        Args:
            package_name: Name of the package
            
        Returns:
            bool: True if successful, False if any errors occurred
        """
        result = self.generate_manifest(package_name)
        if result:
            self.logger.info(f"Successfully processed package: {package_name}")
        else:
            self.logger.error(f"Failed to process package: {package_name}")
        return result


def main():
    """Main entry point."""
    parser = argparse.ArgumentParser(description="Generate Hermit manifest files for Python packages")
    parser.add_argument("package", nargs='+', help="Package directory name(s) (under python/)")
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
    logger = logging.getLogger('hermit_manifest_generator')
    
    package_dir = Path("python")
    if not package_dir.exists():
        logger.error(f"Package directory not found: {package_dir}")
        sys.exit(1)
    
    try:
        generator = HermitManifestGenerator(package_dir=package_dir)
        
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
