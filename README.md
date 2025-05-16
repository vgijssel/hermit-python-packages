# Hermit Python Packages

## Overview

This repository builds and publishes Python packages as [Python executables (PEXs)](https://docs.pex-tool.org/) for the [Hermit](https://cashapp.github.io/hermit/) project. Together with [Hermit](https://cashapp.github.io/hermit/) it becomes possible to pull and run Python tools without configuring a Python environment. The pex executables are standalone and do not require any additional dependencies.

The PEX files are published to the GitHub releases and pulled down using HTTP requests using Hermit. This makes it easy to manage multiple versions of the same tool and for different platforms as well. Currently macOS and Linux are supported.

## Build Pipeline

1. `generate_state.py`
2. `generate_releases.py`
3. `generate_requirements.py`
4. `generate_pex.py`
5. `generate_build_info.py`
6. `generate_hermit.py`

## Implementation

Each Python package has it's own directory in the `hermit-python-packages` repository. For example `python/aider-chat`. The directory contains a `config.yaml` file that defines the following configuration options:

```yaml
binaries:
  - aider

package: aider-chat

versions:
  - version: 0.80.0
    python: 3.11

  - version: 0.83.1
    python: 3.12
```

All versions of the package are queried from the PyPI API starting with the lowest version specified in `versions` up to latest. Each patch, minor and major version of a Python package is built as a PEX file. For each binary specified in `binaries` a bash script is made which invokes the PEX file looking for a console script / entry point with the same name as the binary. 

The bash script is named after the binary and is placed in the same directory as the PEX file. For example `dist/aider/0.83.1/aider-chat-macos-arm64.pex` will have a bash script named `aider-macos-arm64` in the same directory.

Once the PEX files and bash scripts are ready they are uploaded to GitHub releases. Once the PEX files are published, the Hermit manifest file is updated to reflect the new versions for the given platform.

## Potential Improvements

- [x] Create a release in "draft" mode. While the release is in draft mode, assets can be uploaded (again) to the release. After all macOS + Linux (arm64/amd64) assets have been uploaded the draft mode is removed.
- [x] Create a release in "prerelease" mode. While the release is in prerelease mode, assets can be uploaded (again) to the release. After all macOS + Linux (arm64/amd64) assets have been uploaded the prerelease mode is removed.
- [x] Only single release has been created? Not all versions?
- [x] Query the releases API once and paginate over all the results. Cross reference versions from pypi and versions releases on GitHub. Include only versions for processing that don't have a release or those that have a draft/prerelease release.
- [x] Ability to pass in list of config files to process. For example `python/aider-chat/config.yaml` and `python/ansible/config.yaml`. This will allow for multiple packages to be processed in one go.
- [x] Ability to overwrite / replace releases.
- [x] Mark release as regular release after all assets have been uploaded.
- [x] Commit files into repository and push to main branch (self updating hermit manifest). Skip CI on this commit!
- [x] Allow jobs to fail, want to continue processing as much as possible.
- [ ] Add Ansible
- [ ] Scheduled workflow every hour to check for new versions
- [ ] Make requirement files part of build_info
- [ ] Re-create requirements files when Python version changes
- [ ] Test packages in Hermit manifest files before making pushing into the repository.
- [ ] Ensure Python 3.10 inside the yaml config is not a number but a string
- [ ] Ability to exclude certain packages which pex is complaining about?
- [ ] Automatically install playwright (and other friends?) inside Aider-Chat.
- [ ] Refactor Github workflow by consolidatiing steps in composite actions