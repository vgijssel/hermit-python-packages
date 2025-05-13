description = "Python tool aider-chat packaged as PEX"
binaries = ["aider"]
test = "aider --help"
repository = "https://github.com/vgijssel/hermit-python-packages"

darwin {
  source = "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v${version}/aider-chat-${os}-${arch}.tar.gz"
}

version "0.83.1" {
  runtime-dependencies = ["python3@3.10"]
}

sha256sums = {
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.83.1/aider-chat-darwin-arm64.tar.gz": "19c37932226e469e01ebdf1e9494ba41e1da9ce48f3f07f40a13ecc491321174",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.83.1/aider-chat-darwin-amd64.tar.gz": "e92e585f2c587b7c6f28984b52ada93aebac8439e8cb4d100eedf947a90147c8",
}
