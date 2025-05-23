description = "Radically simple IT automation"
binaries = ["ansible", "ansible-config", "ansible-console", "ansible-doc", "ansible-galaxy", "ansible-inventory", "ansible-playbook", "ansible-pull", "ansible-vault", "ansible-test"]
test = "ansible --help"
repository = "https://github.com/vgijssel/hermit-python-packages"
source = "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v${version}/ansible-${os}-${arch}.tar.gz"

version "11.6.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "11.5.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "11.4.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "11.3.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "11.2.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "11.1.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "11.0.0" {
  runtime-dependencies = ["python3@3.11"]
}

sha256sums = {
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.0.0/ansible-darwin-amd64.tar.gz": "33131ad344a800647c276a554f331c0adadcf4ec684db67a723500bea2b3c888",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.0.0/ansible-darwin-arm64.tar.gz": "d1cf4bf27ea5149a1afd0b0ca46c621907f5a59f1a1b8337618e703b917f7250",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.0.0/ansible-linux-amd64.tar.gz": "ae555d204937f192e8e0ac00021e64e0b098fe3a2c391a20273d933c247a9d72",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.0.0/ansible-linux-arm64.tar.gz": "d33ba9327fd73f6325e04d2430f3bee12e900c32f4a58e36f84544b226870af9",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.1.0/ansible-darwin-amd64.tar.gz": "59e893317a96333a306cc191f487b09f310bddcd6d802bed3c7238f94c71166c",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.1.0/ansible-darwin-arm64.tar.gz": "af0ff9be6784a1c4c85011e785022a29eb1b09752d99ca5d25efe481a9b007b4",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.1.0/ansible-linux-amd64.tar.gz": "319fbec2c8316fbd983c8e1253265b793548e4a2a66e06c77bac135397bd8681",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.1.0/ansible-linux-arm64.tar.gz": "c7b36a131aab3e34d390dd6bc27ab5c72ef9ec9da534bb875ddc7d53f17022b2",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.2.0/ansible-darwin-amd64.tar.gz": "adcd36f21575c3dc0f07800e9ff4fd614b72e471104e9b72eff349c2c13b90ad",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.2.0/ansible-darwin-arm64.tar.gz": "9877e4b1b5478ede4e296d75b020f4285e8aca884fc600f26e6e18eafd8dd731",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.2.0/ansible-linux-amd64.tar.gz": "8c3af5730a6c212d29e2e29715c10d53c012fe4a1a2d93f6952074a2fe800968",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.2.0/ansible-linux-arm64.tar.gz": "870a3485d50096bd7f4c9c1120f40814e6941af4103072b0bfe0f258c3ca307e",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.3.0/ansible-darwin-amd64.tar.gz": "d2a5f1ccf577799412bc056f16c6a0238b858d43491186ef8a1779d13ff0638c",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.3.0/ansible-darwin-arm64.tar.gz": "9cf9cefefcd63073e2cce6126848349e6f3c16b0c9db6e8a626fad0e5341cd76",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.3.0/ansible-linux-amd64.tar.gz": "73065b36495fb2060acebed6bba9302df18647b83d5cabad7be5d972dfbdf1a8",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.3.0/ansible-linux-arm64.tar.gz": "0e40fa6c932ea3d031f6c5d5bc5b0f395b5632ae6efbe7314af4861059cd02dc",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.4.0/ansible-darwin-amd64.tar.gz": "b062d72ed38440235e009ffc325b85e4e9b5cf5a7f8757cc5b18cdef69473ab5",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.4.0/ansible-darwin-arm64.tar.gz": "36369f5ee0492acb4830652500ad6f2528b04aea8b587f136ec78ef6a2caaf1b",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.4.0/ansible-linux-amd64.tar.gz": "13a6f1396fc50666f01807f4f973eb42f7e5f484eef509120b09e10ba136b06f",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.4.0/ansible-linux-arm64.tar.gz": "0cb6cec02e9c19e116bb52af86c342ec45cc7c5c4d119eda6e8582223d106f99",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.5.0/ansible-darwin-amd64.tar.gz": "59c78a00747f6864d69f9635338269f817cb9af8d0c7922f838d6bb47786221f",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.5.0/ansible-darwin-arm64.tar.gz": "29ef400b1e1b7f6d924dff68b65e105682d104326949ea1e893ab8de08854b2d",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.5.0/ansible-linux-amd64.tar.gz": "e19ce71cfc1bae5141f16572bf62e983c14ac314fc311902c5694d2dbe2baf88",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.5.0/ansible-linux-arm64.tar.gz": "1388ba731a86cce337c85dfcc05195e8d375a395eae57d9454859b4ab3e46d81",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.6.0/ansible-darwin-amd64.tar.gz": "045b0a32ee90790a36675a0b3817cd722b81b697dfba4b682cbbdfb5495c21bb",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.6.0/ansible-darwin-arm64.tar.gz": "24b6f5378ef1464ffb29d4218cc6cdbeb64f6dba67a90143748b41f185090ce0",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.6.0/ansible-linux-amd64.tar.gz": "804b25e6f921b2c91bf4c8a3571d3fd9e017376f4c5bffec22be13a2200ee83b",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.6.0/ansible-linux-arm64.tar.gz": "c8007303c7e62c882ad270469bb1fd701448c1d2851c288395dc7dd0a05a01be",
}