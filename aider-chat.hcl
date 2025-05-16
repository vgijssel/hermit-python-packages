description = "Aider is a command-line tool that helps you write better code by providing real-time feedback and suggestions as you type."
binaries = ["aider"]
test = "aider --help"
repository = "https://github.com/vgijssel/hermit-python-packages"
source = "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v${version}/aider-chat-${os}-${arch}.tar.gz"

version "0.83.1" {
  runtime-dependencies = ["python3@3.11"]
}
version "0.83.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "0.82.3" {
  runtime-dependencies = ["python3@3.11"]
}
version "0.82.2" {
  runtime-dependencies = ["python3@3.11"]
}
version "0.82.1" {
  runtime-dependencies = ["python3@3.11"]
}
version "0.82.0" {
  runtime-dependencies = ["python3@3.11"]
}

sha256sums = {
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.82.0/aider-chat-darwin-arm64.tar.gz": "b1fce4c2394c4f294dbfa7a6a049d281f882babadc4919bc02c75f27c412dceb",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.82.1/aider-chat-darwin-arm64.tar.gz": "5a16efa66d4df3d8ec5c0d2057ca947add35b72fb701fdc3a69a0f1cdca56349",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.82.2/aider-chat-darwin-arm64.tar.gz": "c3f309a651fb861713af8b2d0cc89dc38d7540546739063c9c45202539a0a389",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.82.3/aider-chat-darwin-arm64.tar.gz": "134b397e4c97c4bb48f7a1f392472aff9cb9597becf72695f9d2e23a7ae7ab3d",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.83.0/aider-chat-darwin-arm64.tar.gz": "f95d68e7037ade72911fa6f282588d3c8a8a1895f07767a4d42ffb7051a94933",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.83.1/aider-chat-darwin-arm64.tar.gz": "d93e15d481fad3c4400c43238e584d0c8c0e244e16dcceb6a57cb6ba4c5cc390",
}