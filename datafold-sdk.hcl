description = "An SDK library for the datafold application."
binaries = ["datafold"]
test = "datafold --help"
repository = "https://github.com/vgijssel/hermit-python-packages"
source = "https://github.com/vgijssel/hermit-python-packages/releases/download/datafold-sdk-v${version}/datafold-sdk-${os}-${arch}.tar.gz"

version "0.0.27" {
  runtime-dependencies = ["python3@3.11"]
}

sha256sums = {
  "https://github.com/vgijssel/hermit-python-packages/releases/download/datafold-sdk-v0.0.27/datafold-sdk-darwin-amd64.tar.gz": "f9c2fde0589a9d431ff7077f44db3afe7b637f453886cf302ff34fc10c047fa8",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/datafold-sdk-v0.0.27/datafold-sdk-darwin-arm64.tar.gz": "e8f1ce945ea3dfeaf60b456941a4f916129eb6a59020bdccb3cf7767b249c09c",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/datafold-sdk-v0.0.27/datafold-sdk-linux-amd64.tar.gz": "719dbd465770d2fa096dd8ae19d3b33b8ae5c9f64d2d7a884dab756374e3646f",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/datafold-sdk-v0.0.27/datafold-sdk-linux-arm64.tar.gz": "d6ce8140d4fe6aacf544ca8f527b0a12252b8e13451b2d8a4f72826df690dcc0",
}