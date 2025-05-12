# Hermit Python Packages

## Overview

This repository builds and publishes Python packages as [Python executables (PEXs)](https://docs.pex-tool.org/) for the [Hermit](https://cashapp.github.io/hermit/) project. Together with [Hermit](https://cashapp.github.io/hermit/) it becomes possible to pull and run Python tools without configuring a Python environment. The pex executables are standalone and do not require any additional dependencies.

The PEX files are published to the GitHub OCI registry and pulled down using HTTP requests using Hermit. This makes it easy to manage multiple versions of the same tool and for different platforms as well. Currently macOS and Linux are supported, but Windows support shouldn't be too difficult to add.

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

The bash script is named after the binary and is placed in the same directory as the PEX file. For example `dist/aider/0.83.1/aider-chat-0.83.1-py3.12.pex` will have a bash script named `aider` in the same directory.

Once the PEX files and bash scripts are ready they are published to the GitHub OCI registry for the current host OS platform. Once the PEX files are published, the Hermit manifest file is updated to reflect the new versions for the given platform.