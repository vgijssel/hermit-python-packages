description = "Radically simple IT automation"
binaries = ["ansible", "ansible-config", "ansible-console", "ansible-doc", "ansible-galaxy", "ansible-inventory", "ansible-playbook", "ansible-pull", "ansible-vault", "ansible-test"]
test = "ansible --help"
repository = "https://github.com/vgijssel/hermit-python-packages"
source = "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v${version}/ansible-${os}-${arch}.tar.gz"

version "12.2.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "12.1.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "12.0.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "11.9.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "11.8.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "11.7.0" {
  runtime-dependencies = ["python3@3.11"]
}
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
version "11.12.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "11.11.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "11.10.0" {
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
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.10.0/ansible-darwin-amd64.tar.gz": "6a908a454946a4ff4d06a9b53f417c5f80e4f5b2cd453127daf97ebe078df2b6",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.10.0/ansible-darwin-arm64.tar.gz": "195186132c543edada20467025d9f2a650ccca4afe7edd893613f8e59338ac79",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.10.0/ansible-linux-amd64.tar.gz": "357f7ffd64d1e3597bed57d586d2b16b4b1296f2f50a4ffbb73ddd38007db86b",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.10.0/ansible-linux-arm64.tar.gz": "211683c0fd4f6ecc9cc11f52eaf2cd47d399364ad06ee0ac9e417f31e8c1f02e",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.11.0/ansible-darwin-amd64.tar.gz": "d8a79c25cc0541af89dce89b3c7c462246b6daebeec8c6be48c567f32e835dd1",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.11.0/ansible-darwin-arm64.tar.gz": "3647f7a8f432dbb1a6a8a4db9ee3502d86ddf373c53523844998b3ea5ba8f96c",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.11.0/ansible-linux-amd64.tar.gz": "2854e92d66cb78d3540d67e9aadcefae481031a6502e47d1ade543c4aff00791",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.11.0/ansible-linux-arm64.tar.gz": "8692089f7855b6258cf7627f46b769ef002b2994d1617b55799f69f9c3b0a83a",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.12.0/ansible-darwin-amd64.tar.gz": "c10e572b88bea79f9e2e79054bab16e32a44afabdd4af11e03f3e55bac781fc6",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.12.0/ansible-darwin-arm64.tar.gz": "848a7a61b62203ee36faa000442bbc8fa4d9a13f996115a2defa9c591bb49860",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.12.0/ansible-linux-amd64.tar.gz": "8ad8287b6d489e6ecc834e0d6de1585e78e6cd1dbaa50923fe8051a63fea401b",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.12.0/ansible-linux-arm64.tar.gz": "f60c041acb07275eac6fecf335694f2d3aff7d7da8fcb0782bcbcb57192f8857",
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
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.7.0/ansible-darwin-amd64.tar.gz": "683072f18c1d11fe9edc1ba77dcfc5a8f92ac0a96790bef06d5c8350037db8bf",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.7.0/ansible-darwin-arm64.tar.gz": "fca8231ef8a14e2475352d5127dba47fd0909561eacd0fa99af321d5375d35a6",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.7.0/ansible-linux-amd64.tar.gz": "9e7d518a323373c38075d420d10c6691b2acf34a139a5a4aace9bd7979d8aa1b",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.7.0/ansible-linux-arm64.tar.gz": "fe90e85a3f11f8979c222241112a052ffddd6c31e50a103392f2c98bf693b2e7",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.8.0/ansible-darwin-amd64.tar.gz": "d3b78dcfbcdf3d22e795dbdbd1353d01a2f5600012b5f87c8074aeb98b8066d3",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.8.0/ansible-darwin-arm64.tar.gz": "4ac7ad17ccd4cc9759e25565b1d8898987a1581768f082af859cfcef71323f68",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.8.0/ansible-linux-amd64.tar.gz": "76cd6efa7ecac78565744bcd59579b5c15ec9962a80165c7d7eb98776c75f7f0",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.8.0/ansible-linux-arm64.tar.gz": "7539f963536c13d6af579a5ad645a53322118030f560c76fa5c54d93ec25577f",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.9.0/ansible-darwin-amd64.tar.gz": "18b8c12506f42cb6a30061b558d6c977fff17dcce6f68840e55ffc4867087294",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.9.0/ansible-darwin-arm64.tar.gz": "3baf7921e8c0654ce7b5ff14328ae3820ee0fd5d4c06a633c76c8e2997d4375e",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.9.0/ansible-linux-amd64.tar.gz": "5b2c571f58965f11d318946a5fbed69c3440145e3a4ac85c1882eff2489649b8",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v11.9.0/ansible-linux-arm64.tar.gz": "a37be00db97fd25c2f6bb289b183f74fe8c9d40d2647c0c7429f574a1ba97f63",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v12.0.0/ansible-darwin-amd64.tar.gz": "bb180cbcdfeedd2ee3e5e8cf58aeebb3c61c876aaea62e3c6ecf16ffe8bd11c3",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v12.0.0/ansible-darwin-arm64.tar.gz": "facc850bdacac8d59a62bcbd5a0411fcc730b1127c3689f1b0dc02ec557b8eff",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v12.0.0/ansible-linux-amd64.tar.gz": "6135fbceafb5ef75754dcdb7b627ef43af02e1c3167dc2bf5a6d02f3dad99123",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v12.0.0/ansible-linux-arm64.tar.gz": "d1c73ba2762b1770fcaf977ffc8ce6b8dac2ca7bd247a7dce2738934fce5ea4e",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v12.1.0/ansible-darwin-amd64.tar.gz": "c10ec3a0faf283235c9570e009f2e05a4a45c57eb1bf4b6c4c31e86f272d272d",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v12.1.0/ansible-darwin-arm64.tar.gz": "190538686e5a515732de070c6144973a3b01b2dd799ff5aa7c9d28e9a502f5d9",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v12.1.0/ansible-linux-amd64.tar.gz": "922679e88be4a60cd07c2e110f34d15a376522427dcf2e6411f2781d61426d22",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v12.1.0/ansible-linux-arm64.tar.gz": "77fa786395c5f4cc75068626387a613d054b12e32fdd44b851871d89ff032dcd",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v12.2.0/ansible-darwin-amd64.tar.gz": "b4e55bd4fbd4db622263033968bc2a449120d1e7f1e8afad52dfbda8b2165111",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v12.2.0/ansible-darwin-arm64.tar.gz": "3ea435dbbe122d5de630286b0ea8753d48751766d3cebcd12bc8f405f3f1d528",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v12.2.0/ansible-linux-amd64.tar.gz": "efa674de5f81b15673ec041fbf86b74244ebb8575e477b630114b23f7aa2d6e3",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/ansible-v12.2.0/ansible-linux-arm64.tar.gz": "58a65a2f49710c2f87a7da0ebe6834c17e035447caa5dd2b167f03b4ff1fcb36",
}