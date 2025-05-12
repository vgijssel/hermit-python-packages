description = "Python tool aider-chat packaged as PEX"
binaries = ["aider"]
test = "aider --help"
runtime-dependencies = ["python3@3.12"]
repository = "https://github.com/vgijssel/hermit-python-packages"

// # https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.83.1/aider-chat-macos-arm64.pex
darwin {
  // # TODO: pinning to arm64 for now
  source = "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v${version}/aider-chat-macos-arm64.tar.gz"
}

version "0.83.1" {
  runtime-dependencies = ["python3@3.12"]
}