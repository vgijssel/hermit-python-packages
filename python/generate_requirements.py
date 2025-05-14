#!/usr/bin/env python3
"""
Generate requirements files for Python packages based on state.yaml files.
"""

import argparse
import os
import subprocess
import sys
from pathlib import Path
from typing import Dict, List, Optional
import yaml


class RequirementsGenerator:
    """Generate requirements files for Python packages based on state.yaml files."""

    def __init__(self, package_dir: str):
        """Initialize the requirements generator.

        Args:
            package_dir: Directory containing the package configurations
        """
        self.package_dir = Path(package_dir)

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

    def create_dependency_files(self, package_name: str, version: str, python_version: str) -> bool:
        """Create dependency files (requirements.in and requirements.txt) for the specified package version.
        
        Args:
            package_name: Name of the package
            version: Version of the package
            python_version: Python version to use
            
        Returns:
            bool: True if successful, False otherwise
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
            return True
        
        print(f"Creating lock file for {package_name}=={version} with Python {python_version}")

        try:
            # Use uv to create a lock file
            cmd = [
                "uv", "pip", "compile", 
                "--output-file", str(req_txt_file),
                str(req_in_file),
                "--python-version", str(python_version)
            ]

            print(f"Running command: {' '.join(cmd)}")
            subprocess.run(cmd, check=True, capture_output=True)
            print(f"Successfully created lock file: {req_txt_file}")
            return True

        except subprocess.CalledProcessError as e:
            if hasattr(e, 'stderr') and e.stderr:
                print(f"Failed to create lock file with uv: {e.stderr.decode()}")
            else:
                print(f"Failed to create lock file with uv: {e}")
            return False

    def process_package(self, package_name: str) -> bool:
        """Process a package: generate requirements files for versions that need them.
        
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
                python_version = version_info['python']
                has_requirements = version_info.get('requirements', False)
                
                if not has_requirements:
                    print(f"Generating requirements for {actual_package_name} {version}")
                    success = self.create_dependency_files(package_name, version, python_version)
                    if success:
                        version_info['requirements'] = True
                        has_changes = True
                    else:
                        print(f"Failed to generate requirements for {actual_package_name} {version}")
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
    parser = argparse.ArgumentParser(description="Generate requirements files for Python packages")
    parser.add_argument("package", nargs='+', help="Package directory name(s) (under python/)")
    
    args = parser.parse_args()
    
    package_dir = Path("python")
    if not package_dir.exists():
        print(f"Error: Package directory not found: {package_dir}")
        sys.exit(1)
    
    try:
        generator = RequirementsGenerator(package_dir=package_dir)
        
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
