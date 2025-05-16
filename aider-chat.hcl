description = "Aider is a command-line tool that helps you write better code by providing real-time feedback and suggestions as you type."
binaries = ["aider"]
test = "aider --help"
repository = "https://github.com/vgijssel/hermit-python-packages"
source = "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v${version}/aider-chat-${os}-${arch}.tar.gz"

version "0.83.1" {
  runtime-dependencies = ["python3@3.11"]
}

sha256sums = {
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.83.1/aider-chat-darwin-arm64.tar.gz": "8911d5ec2f06a9de1b4c7d56d777effc47590596d747e914b98cd6c8623cc4c8",
}