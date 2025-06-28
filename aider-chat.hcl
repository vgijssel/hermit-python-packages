description = "Aider is a command-line tool that helps you write better code by providing real-time feedback and suggestions as you type."
binaries = ["aider"]
test = "aider --help"
repository = "https://github.com/vgijssel/hermit-python-packages"
source = "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v${version}/aider-chat-${os}-${arch}.tar.gz"

version "0.85.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "0.84.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "0.83.2" {
  runtime-dependencies = ["python3@3.11"]
}

sha256sums = {
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.83.2/aider-chat-darwin-amd64.tar.gz": "a4754b436b7446ab9a449b0c9da1a2c0f01bc3d87b93a549850b3c6692d170c7",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.83.2/aider-chat-darwin-arm64.tar.gz": "264257e30aa5cf36e24561b13797fbd8521e9557cb0b3ff75f321fba8e34ecc8",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.83.2/aider-chat-linux-amd64.tar.gz": "a67cdaae58d2cee32ec3ef420e0824548d57eaa685d49664952719380af44979",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.83.2/aider-chat-linux-arm64.tar.gz": "c8bf8e96461765201633ae578c2c239fcbd2fde1bac45b559069abfede128945",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.84.0/aider-chat-darwin-amd64.tar.gz": "c138b1082b08bf6181199d246eb55c6cc77c09444486dbdf8f881be989f27bfe",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.84.0/aider-chat-darwin-arm64.tar.gz": "664b154564afc2e45f019197c43f6ded3854c2208609d0dc72ed2d173093e0ae",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.84.0/aider-chat-linux-amd64.tar.gz": "68d063db46e87b070d5a6a8f78c9d221e2cfabaef1272c92aad9f6aca4ccb475",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.84.0/aider-chat-linux-arm64.tar.gz": "0a1fae932e658a5d57cc94ac29e1f54d69a09f4731e5ededf516b8fa93300d85",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.85.0/aider-chat-darwin-amd64.tar.gz": "947c14c677f468c0d2ecc03ac885b0b66a102fd2aa3eaee4f78e6c7242782c47",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.85.0/aider-chat-darwin-arm64.tar.gz": "b336e1f595b5136293c035939f924c962472b6f824f5321649b151e1aff23ea5",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.85.0/aider-chat-linux-amd64.tar.gz": "727e506ef91d8b3f358928e516b44697efde1384ec89125cc6b758d64552c542",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.85.0/aider-chat-linux-arm64.tar.gz": "e06e2b22f2a2971b311d4583a130836038209363e0beb03a988eabb76e93f29c",
}