description = "Python tool aider-chat packaged as PEX"
binaries = ["aider"]
test = "aider --help"
runtime-dependencies = ["python3@3.12"]
repository = "https://github.com/vgijssel/hermit-python-packages"

// # https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.83.1/aider-chat-macos-arm64.pex
darwin {
  // # TODO: pinning to arm64 for now
  source = "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v${version}/aider-chat-macos-arm64.pex"
}

on "unpack" {
  rename {
    from = "${root}/aider-${os}-${arch}"
    to = "${root}/aider"
  }

  chmod {
    file = "${root}/aider"
    mode = 493
  }
}

version "0.83.1" {
  runtime-dependencies = ["python3@3.12"]
}

sha256sums = {
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.83.1/aider-chat-macos-arm64.pex": "0fe2db473cf16c6e676efc6339bb5fdccbbdaae083a51ed1a8a8fef5dfb863c0",
}
