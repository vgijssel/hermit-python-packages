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