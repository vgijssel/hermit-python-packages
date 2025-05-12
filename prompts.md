# Prompts

## Getting started

As described in README.md can you implement a Python script using Pants that does the following:

1. Create a Python script that loads in the `config.yaml` file in `python/aider-chat`
2. Extracts the lowest version
3. Queries pypi for all possible versions of `aider-chat` starting with the lowest version
4. Using the `pex` tool create a pex file for each version
5. Upload the pex file to the GitHub OCI registry
6. Update the Hermit manifest for aider-chat in hermit/aider-chat.hcl with a reference to the OCI blob