# Prompts

## Getting started

As described in README.md can you implement a Python script using Pants that does the following:

1. Create a Python script that loads in the `config.yaml` file in `python/aider-chat`
2. Extracts the lowest version
3. Queries pypi for all possible versions of `aider-chat` starting with the lowest version
4. Using the `pex` tool create a pex file for each version
5. Upload the pex file to the GitHub OCI registry
6. Update the Hermit manifest for aider-chat in hermit/aider-chat.hcl with a reference to the OCI blob

## Create Bash scripts

Implement writing Bash scripts to the dist directory for each binary in the `binaries` configuration option. The script should be named after the binary and should be placed in the same directory as the PEX file. The script should execute the PEX file with the appropriate arguments.

After the pex file is built for a particular version in the dist directory, for example `dist/aider/0.83.1/aider-chat-0.83.1-py3.12.pex`, create an executable Bash script inside the same directory as the pex file for each item in the "binaries" configuration option. The bash script will be invoked as "PEX_SCRIPT=aider aider-chat-0.83.1-py3.12.pex" and will execute the pex file with the appropriate arguments. The script should be named after the binary, for example `dist/aider/0.83.1/aider`. 

## Add os and arch to the PEX file name

Add in os and arch to the filename. For example: `aider-linux-x86_64.pex`

## Create GitHub release

Call the Github API to list out all releases, use pagination in case there are too many releases. Figure out if there is a release for the current version of the package. If it already exists, skip the package version. If it does not exist, create a new release and upload the pex and binary files into the release. Make sure that the tag of the GitHub release includes both the package name and the version number. For example: `aider-chat-v0.83.1`. Prefer using a Python library to call the GitHub API.

## Create archive of the pex and bash files

Create a tarball of the pex and bash files for each version. The tarball should be named after the package, os and architecture. For example `aider-chat-macos-arm64.tar.gz`. The tarball should include the PEX file and the bash scripts. The archive is the only thing that's uploaded to the GitHub release. The PEX file and bash scripts should be in the root of the archive. The archive should be created in the dist directory.

## Pre-Release

Create a release in "prerelease" mode. While the release is in prerelease mode, assets can be uploaded (again) to the release. If a release is in prerelease mode it will not be skipped by the pex builder. Only after all macOS arm64 / amd64 assets and linux arm64 / amd64 assets have been uploaded the prerelease mode is removed.

##  GitHub Actions

Create a GitHub action that runs on push to the main branch. The action should use the `actions/checkout` action to check out the code. The action should use Hermit to install all necessary dependencies. The action should setup direnv to make sure the environment is the same. The action should run `task pex:build` which will create the necessary releases. Create a job for macOS arm64 and amd64 and linux arm64 and amd64. 

## Exit code

Ensure that the build_pex_packages.py script exits with a non-zero exit code if any of the steps fail. This includes checking for the existence of the config.yaml file, creating the pex exectuable, checking for the existence of the GitHub API token. If any of these steps fail, the script should be marked as a failure but should continue processing until all versions have been processed. Missing GitHub API token should be a hard failure. If that misses the script should exit immediately with a non-zero exit code.

## Generate Hermit manifest

Create a separate script called `create_hermit_manifest.py` that generates the Hermit manifest based on all GitHub releases. For this query all GitHub releases. Skip all releases that are still a prerelease. Cross reference all config.yaml files and GitHub releases and create a single, only one, manifest for each package. This manifest is going to written in the root directory and will be named after the package. For example `aider-chat.hcl`. The manifest looks something like this:

```hcl
description = "Python tool aider-chat packaged as PEX" # comes from the config.yaml file
binaries = ["aider"] # binaries come from the config.yaml file
test = "aider --help" # test command comes from the config.yaml file
repository = "https://github.com/vgijssel/hermit-python-packages" # comes from the config.yaml file

# The source is the URL to the tarball archive
source = "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v${version}/aider-chat-${os}-${arch}.tar.gz"

# Each individual version is listed here
version "0.83.1" {

  # The necessary python version is listed here based on the config.yaml file
  runtime-dependencies = ["python3@3.10"]
}

# The sha256 digest of the tarball archive is listed here
sha256sums = {
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.83.1/aider-chat-darwin-arm64.tar.gz": "19c37932226e469e01ebdf1e9494ba41e1da9ce48f3f07f40a13ecc491321174",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.83.1/aider-chat-darwin-amd64.tar.gz": "e92e585f2c587b7c6f28984b52ada93aebac8439e8cb4d100eedf947a90147c8",
}
```

This means that each GitHub release also needs to contain the sha256 digest of the tarball archive. The sha256 digest is calculated based on the tarball archive. The sha256 digest is used to verify the integrity of the tarball archive.

## Use CirrusCI for Linux jobs

Create a CirrusCI configuration file that runs the Linux jobs. The CirrusCI configuration file should be named `.cirrus.yml` and should be placed in the root directory. https://cirrus-ci.org/guide/writing-tasks/ contains instructions for writing tasks. The configuration should have two tasks: one for Linux arm64 and one for Linux amd64. The configuration should install direnv and hermit and run the `task pex:build` command. 


Do step 4 and 5 for the following project:

## Rearchitecture the project

I want the project to be split up into the following scripts:

1. generate_state.py
2. generate_requirements.py
3. generate_releases.py
4. generate_pex.py
5. generate_hermit_manifest.py

### 1. generate_state.py

This script will be responsible for generating the state of the project. This will take in any number of config.yaml files and generate the same number of state files. For example `python/aider-chat/config.yaml` will generate `python/aider-chat/state.yaml`. The state file will contain the following information for each version of the package:

```yaml
versions:
  - version: 0.82.3 # package version
    python: 3.11 # python version
    requirements: true # if the requirements file was generated 
    release: true # if the release was generated
    assets: # what assets are included in the release
      "aider-chat-linux-amd64.tar.gz": "fd2e04a0f21f8a0d48b583753bbd6b0c63091f56dd4e030e902fb2326ec6d79c"
      "aider-chat-linux-arm64.tar.gz": "091f6f2fdc0507c3d348e7db3302f322c8ac3ec47ba2043741c16e5cba8b8489"
      "aider-chat-darwin-amd64.tar.gz": "12f96904b88c3d2b961ae6722820e5ed6b5f12a6bf38ba569528462811743f79"
      "aider-chat-darwin-arm64.tar.gz": "25e666d6160d60e61e9811771c1bc93c6d43792dbdc8dbaa76cb9b2e9e13e0db"
```

This state file will be generated by a combination of `config.yaml`, the `pypi`, Github releases API and the repository. `config.yaml` will be used to determine the package name, generated binaries, python version and starting version. The `pypi` API will be used to determine all of the available versions of the package starting with the starting version from `config.yaml`. The GitHub releases API will be used to determine if a release already exists for the package version. If the release exists the assets of the release and their sha256 digest will be included in the state file. The repo will be scanned for requirements file associated with the package version.

### 2. generate_requirements.py

This script will be responsible for generating the requirements files for each version of the package. It's the same method already defined in python/build_pex_packages.py in the `create_dependency_files` method. It will use the state files to determine which package versions don't already have a requirements file. It will generate the requirements file and update the state file with the result. The requirements file will be generated in the same directory as the config.yaml file. The requirements file will be named after the package version. For example `python/aider-chat/0.83.1/requirements.in` and `python/aider-chat/0.83.1/requirements.txt`. 

### 3. generate_releases.py

This script will be responsible for generating the releases for each version of the package. It will use the state files to determine which package versions don't already have a release. It will create a release marked as `prerelease` for all package versions that don't already have a release and have a requirements file. Once the release is created the state file will be updated.

### 4. generate_pex.py

This script will be responsible for generating the pex files for each version of the package. It will use the state files to determine which package versions have a release and are missing assets. It will generate the pex file, bash scripts and tarball archive. The state files are updated with the sha256 of the tarball archive. The pex file build method will be the same as the one already defined in python/build_pex_packages.py in the `build_pex` method. The generate_pex script will be run on different platforms. macOS arm64, macOS amd64, Linux arm64 and Linux amd64.

### 5. generate_hermit_manifest.py

This script will be responsible for generating the Hermit manifest file for each version of the package. It will use the state files to determine which package versions have all of the necessary assets defined in the state file. It will create a single manifest file for all of the package versions. The manifest file will be created in the root directory of the repository. The manifest file will be named after the package. For example `aider-chat.hcl`. The manifest file will use the sha256 digest from the state file to verify the integrity of the tarball archive. 

## Use a Jinja2 template for the Hermit manifest

Ensure that each version in the created Hermit manifest in python/generate_hermit_manifest.py specifies `runtime-dependencies = ["python3@3.10"]` within the version block indicating the Python version used for that package version. Secondly create the hermit manifest using a Jinja2 template for better readability.

## Use the GitHub release to store build information

The GitHub release associated with the pex binary, bash scripts and tarball archive should also include the build information. The build information contains the Python version and the sha256 digest of each individual tarball archive. The build information is stored in the GitHub release inside the description as yaml. When running `python/generate_state.py` this information is extracted and parsed and used to update the state file. The build information is stored in the GitHub release as a yaml block. For example:

```yaml
config_version: 1
assets:
  aider-chat-darwin-arm64.tar.gz: 29100fb6e7c8a5ecb5a0711033113364f71c9c33d0c12ea65b54b1996d72ec31
python: '3.11'
version: 0.83.1
```

This build information is written to the GitHub release in the script `generate_build_info.py`. The `generate_pex.py` script will no longer upload the digest and will only update the state file with the sha256 digest of the tarball archive. 

## Only update the build information if there is a change

The `generate_build_info.py` script will only update the build information if there is a change. The build_info from the state file should be compared to the build_info that's generated. If both the dicts are the same the build information is not updated. The build information is only updated if there is a change.

## Release Info

The Github release has the following information:

```yaml
build_info:
  config_version: 2
  python: '3.11'
  version: 0.83.1
  binaries:
    - aider
asset_info:
  aider-chat-darwin-arm64.tar.gz: 71b68756b60f23991b855c7ff428afea27d64ab5b037656ce4d87651e60fa88b
```

This release information is uploaded in the `generate_build_info.py` script. The release info is downloaded in the `generate_state.py` script and used to update the state file. If the `build_info` changed the associated release should be deleted and re-created in `generate_releases`. If the release is deleted, empty the `release_info` in the state file. If the `asset_info` changed the release info should be updated in `generate_build_info.py`.
