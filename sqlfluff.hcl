description = "The SQL Linter for Humans"
binaries = ["sqlfluff"]
test = "sqlfluff --help"
repository = "https://github.com/vgijssel/hermit-python-packages"
source = "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v${version}/sqlfluff-${os}-${arch}.tar.gz"

version "3.4.2" {
  runtime-dependencies = ["python3@3.11"]
}
version "3.4.1" {
  runtime-dependencies = ["python3@3.11"]
}

sha256sums = {
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.4.1/sqlfluff-darwin-amd64.tar.gz": "ce9bf9000ec569b28938de635ae21a6ebb812e020fa0225d7412a50d222087f7",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.4.1/sqlfluff-darwin-arm64.tar.gz": "7650edcb675a9f6b9bf30c1ef3e6b284b4e2b1e234c60a7f12ce4b91e2d8be65",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.4.1/sqlfluff-linux-amd64.tar.gz": "713c2dffca06cb1edabb0c38f56ce1a92bccec3982735d2523b5aa7c90a47eb5",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.4.1/sqlfluff-linux-arm64.tar.gz": "a83998938ad3ab78c7833b9c1c56e5f10e6a0c0dc3814f0c59f85538a10912aa",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.4.2/sqlfluff-darwin-amd64.tar.gz": "335b3111479035c01322252c4fc295f7061f2a4163dcdf724b3103feac3e362b",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.4.2/sqlfluff-darwin-arm64.tar.gz": "3dcff5a0f3b67b02b1cd021240afabcd847368b3833a2326282ba92d9c00855b",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.4.2/sqlfluff-linux-amd64.tar.gz": "20a0c9ce629f70e3edc8760ca9667ad1de4340442181139c08d4e1315c1e8c39",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.4.2/sqlfluff-linux-arm64.tar.gz": "b36344087741fbabd3ec9d224473af7339d996f8c82734f928098f48607603f2",
}