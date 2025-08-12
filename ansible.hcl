description = "Radically simple IT automation"
binaries = ["ansible", "ansible-config", "ansible-console", "ansible-doc", "ansible-galaxy", "ansible-inventory", "ansible-playbook", "ansible-pull", "ansible-vault", "ansible-test"]
test = "ansible --help"
repository = "https://github.com/vgijssel/hermit-python-packages"
source = "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v${version}/ansible-${os}-${arch}.tar.gz"

version "11.8.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "11.7.0" {
  runtime-dependencies = ["python3@3.11"]
}

sha256sums = {
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.7.0/ansible-darwin-amd64.tar.gz": "683072f18c1d11fe9edc1ba77dcfc5a8f92ac0a96790bef06d5c8350037db8bf",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.7.0/ansible-darwin-arm64.tar.gz": "fca8231ef8a14e2475352d5127dba47fd0909561eacd0fa99af321d5375d35a6",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.7.0/ansible-linux-amd64.tar.gz": "9e7d518a323373c38075d420d10c6691b2acf34a139a5a4aace9bd7979d8aa1b",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.7.0/ansible-linux-arm64.tar.gz": "fe90e85a3f11f8979c222241112a052ffddd6c31e50a103392f2c98bf693b2e7",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.8.0/ansible-darwin-amd64.tar.gz": "d3b78dcfbcdf3d22e795dbdbd1353d01a2f5600012b5f87c8074aeb98b8066d3",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.8.0/ansible-darwin-arm64.tar.gz": "4ac7ad17ccd4cc9759e25565b1d8898987a1581768f082af859cfcef71323f68",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.8.0/ansible-linux-amd64.tar.gz": "76cd6efa7ecac78565744bcd59579b5c15ec9962a80165c7d7eb98776c75f7f0",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.8.0/ansible-linux-arm64.tar.gz": "7539f963536c13d6af579a5ad645a53322118030f560c76fa5c54d93ec25577f",
}