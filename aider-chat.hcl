description = "Aider is a command-line tool that helps you write better code by providing real-time feedback and suggestions as you type."
binaries = ["aider"]
test = "aider --help"
repository = "https://github.com/vgijssel/hermit-python-packages"

darwin {
  source = "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v${version}/aider-chat-${os}-${arch}.tar.gz"
}

version "0.83.0" {
}

version "0.82.3" {
}

version "0.83.1" {
}

sha256sums = {
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.83.0/aider-chat-darwin-amd64.tar.gz": "0385f9cfd9ced7bdd8d9089c960f6f0a5798c0ef1c239408d1f9801f42e50fe0",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.83.0/aider-chat-darwin-arm64.tar.gz": "82dd02d772e474b6b32d81cd38b5e6b96f72a8e4b266b86c8f3f068c60a5337e",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.82.3/aider-chat-darwin-amd64.tar.gz": "c551de96c5c114d03e3b6dbbdda1654e00fa8c9a6093dcb525411afca4dfa104",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.82.3/aider-chat-darwin-arm64.tar.gz": "0a1c6057895104b1a0156f2387cd15c2507e78f2b6aa29e72cfc9534ee14e65d",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.83.1/aider-chat-darwin-amd64.tar.gz": "f59ec69c35a9a066507c616f806e49d68cc1dac9de57d0a212e5ee0f134f7bbc",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.83.1/aider-chat-darwin-arm64.tar.gz": "d85c54ba4eac1843d585b6467cec867804a7515bbc6836848b0aa6f48e4fb1d0",
}
