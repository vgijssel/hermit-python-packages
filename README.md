# Hermit Python Packages

## Overview

This repository builds and publishes Python packages as [Python executables (PEXs)](https://docs.pex-tool.org/) for the [Hermit](https://cashapp.github.io/hermit/) project. Together with [Hermit](https://cashapp.github.io/hermit/) it becomes possible to pull and run Python tools without configuring a Python environment. The pex executables are standalone and do not require any additional dependencies.

The PEX files are published to the GitHub OCI registry and pulled down using HTTP requests using Hermit. This makes it easy to manage multiple versions of the same tool and for different platforms as well. Currently macOS and Linux are supported, but Windows support shouldn't be too difficult to add.