description = "Python tool aider-chat packaged as PEX"
binaries = ["aider"]
test = "aider --help"
repository = "https://github.com/vgijssel/hermit-python-packages"
source = "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v${version}/aider-chat-${os}-${arch}.tar.gz"

version "0.83.1" {
  runtime-dependencies = ["python3@3.10"]
}

sha256sums = {
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.83.1/aider-chat-macos-arm64.tar.gz": "917b70877b9ef9024b5403c408c2e9a3e031fac304e7192c50b7350417b8143e",
}
