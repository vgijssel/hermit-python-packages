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

```bash
gh release create aider-chat-v0.83.1 \
  --title "aider-chat-v0.83.1" \
  --notes "python_version: 3.12, ..." \
  --target main \
  ./aider ./aider-chat-0.83.1-py3.12.pex
```

# aider-chat-v0.83.1-macos-aarch64