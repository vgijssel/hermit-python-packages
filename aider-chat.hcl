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
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.82.0/aider-chat-darwin-amd64.tar.gz": "1e60b7b26928f38f8a32dd965319ce0b45e1687614b143e880d17647e3aa9bf6",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.82.0/aider-chat-darwin-arm64.tar.gz": "755d52855769903952fb668e799dae42db293f70269c207276904e6471c7ecb6",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.82.0/aider-chat-linux-amd64.tar.gz": "72801afcd5d85abf49028307b9d22b259aa5d12edaac77e80da22c02f6366271",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.82.0/aider-chat-linux-arm64.tar.gz": "c9fb5b0061397f49e4e4a057931234fc0f6d21e9c63f0ccc44bc4e217a47fb94",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.82.1/aider-chat-darwin-amd64.tar.gz": "91138c89b6e95eb4c136a4c5d1c5ffc787aed52146aa84fa991e4133767b75e4",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.82.1/aider-chat-darwin-arm64.tar.gz": "20f7f5d7c0e62368e920776038861e2cc4645bc47de004d96c333b4dc9765582",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.82.1/aider-chat-linux-amd64.tar.gz": "d82ab7a7a282a6dd524d2926ae43a094496f7cd5747f1b44498bbd0f90451f8a",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.82.1/aider-chat-linux-arm64.tar.gz": "c2b558fa9290d0e555add0afdd9fa856c26bce088a5c3b77830bc770acdcee16",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.82.2/aider-chat-darwin-amd64.tar.gz": "aa2089df88e51aaef851b74e32fc8f2d195dec5bd81dea2f2b662d4f4395843f",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.82.2/aider-chat-darwin-arm64.tar.gz": "81252a3232d8b1d22316db4baf9c883d319d768edca13204d39749b0514f91ee",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.82.2/aider-chat-linux-amd64.tar.gz": "c28841faf0966c902d983015ae44612fa1b90e95847ec658972ad6fee0bdf6c4",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.82.2/aider-chat-linux-arm64.tar.gz": "df6e55599069a495e12a9a5ae869fa17cd05627e0eb6eb6b3ae39996472a5940",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.82.3/aider-chat-darwin-amd64.tar.gz": "dac39e687d5bd32c269d4d306f9459cd1f40300ddd09bfab525b0d2639f87e7e",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.82.3/aider-chat-darwin-arm64.tar.gz": "e8d65c28a01241738c68c3a590612269aabedb29fc9e8f9568be049c193b0fea",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.82.3/aider-chat-linux-amd64.tar.gz": "9895be956770f690b734367616504d23397bda4788e82b017dd7fd8ce1473ade",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.82.3/aider-chat-linux-arm64.tar.gz": "f12e2c1ac5dc5d06d13c9d3b09f06109c9ceadd3d9e5824a5a2a999d44756bac",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.83.0/aider-chat-darwin-amd64.tar.gz": "6e8185ee7002c1ea3e014493e004af0999f6e5b0e3a8a033b1fd56ee3f08b240",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.83.0/aider-chat-darwin-arm64.tar.gz": "79e894332fce3dbe7b3bebc852fbaac09e36f36ab3a92cf1e8ca98f3a2ef698d",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.83.0/aider-chat-linux-amd64.tar.gz": "cb5acb642c4cc2194060e980dcb0564f84480ed1c0a1ba428885aa2b986950af",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.83.0/aider-chat-linux-arm64.tar.gz": "b82bde6972f09cc17a7cf94b9681e7fb301e3b14750eaf22947cc894e3970fe7",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.83.1/aider-chat-darwin-amd64.tar.gz": "167040cd47a51f5d33e60ee5ca38b4b8d88ff10bd0c5f95646936c60d17071cd",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.83.1/aider-chat-darwin-arm64.tar.gz": "27db70471333ad1fb6b8cc73326e0b5f01bff3eb95f1ad98e7963d223324321f",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.83.1/aider-chat-linux-amd64.tar.gz": "f8d6c89b702ed8400085a3315e7400b5d2cc8c02fdb6867a36231449eb0a0bc7",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/aider-chat-v0.83.1/aider-chat-linux-arm64.tar.gz": "bf1be58d68b2dc4a6f29b18f14ed57434c5c057185a5e2b74bf51cf406762a2e",
}