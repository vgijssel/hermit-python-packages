description = "The SQL Linter for Humans"
binaries = ["sqlfluff"]
test = "sqlfluff --help"
repository = "https://github.com/vgijssel/hermit-python-packages"
source = "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v${version}/sqlfluff-${os}-${arch}.tar.gz"

version "3.4.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "3.3.1" {
  runtime-dependencies = ["python3@3.11"]
}
version "3.3.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "3.2.5" {
  runtime-dependencies = ["python3@3.11"]
}
version "3.2.4" {
  runtime-dependencies = ["python3@3.11"]
}
version "3.2.3" {
  runtime-dependencies = ["python3@3.11"]
}
version "3.2.2" {
  runtime-dependencies = ["python3@3.11"]
}
version "3.2.1" {
  runtime-dependencies = ["python3@3.11"]
}
version "3.2.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "3.1.1" {
  runtime-dependencies = ["python3@3.11"]
}
version "3.1.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "3.0.7" {
  runtime-dependencies = ["python3@3.11"]
}
version "3.0.6" {
  runtime-dependencies = ["python3@3.11"]
}

sha256sums = {
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.0.6/sqlfluff-darwin-amd64.tar.gz": "fe71555e01cf9628b2258c72ef5b24030ea1b4720c726837ba5fffab3e98d980",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.0.6/sqlfluff-darwin-arm64.tar.gz": "3c7fbf67a923e099703fd92913f280a465e8c1eb8ab1f24b4bcb1aef4f00e133",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.0.6/sqlfluff-linux-amd64.tar.gz": "89f07cdb902c13f228c062e2243606cf6308a278e2544390e9bb3cdc4f34f77e",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.0.6/sqlfluff-linux-arm64.tar.gz": "0313a5cb371f5d9c7371015824f8bd86ee9c3d16f450c31f224274ce5e64e394",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.0.7/sqlfluff-darwin-amd64.tar.gz": "f1afa35a439787bd5eee5e04d3f53b7699d02ba13c3a06726189bc0b3d2c2468",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.0.7/sqlfluff-darwin-arm64.tar.gz": "f1c8af838f56c488fbad50b756924b6527b94cb264ba54c2195f34184d946622",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.0.7/sqlfluff-linux-amd64.tar.gz": "8db624115f67bc89a2f3d2041ec4db396f4764d28c6fe9f9bf2448c5048ad1f0",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.0.7/sqlfluff-linux-arm64.tar.gz": "1755dfcdba5eaec33841f43fc6e336743edf412207923aae4a816035b2806717",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.1.0/sqlfluff-darwin-amd64.tar.gz": "f6c347f39341c6b78e848067f009250e08304f48c5edf1b5ffc87b867a3672bf",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.1.0/sqlfluff-darwin-arm64.tar.gz": "dc2970f01f480b94cea55302c5a21005ee090846dd0b2fd7723ba2f8f823dee0",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.1.0/sqlfluff-linux-amd64.tar.gz": "61bf7cfaa2c832fa3c483e41cb7da2282d022b8b268664a5ae6c22249cf4e0c0",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.1.0/sqlfluff-linux-arm64.tar.gz": "fcba03d8891f15e95d482d766c1bf216a375bc72553fa86736116f63c92890d0",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.1.1/sqlfluff-darwin-amd64.tar.gz": "be0f34987768715f54c03af3c84064a71c4274f0f03c805f51f52c5339acd1dc",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.1.1/sqlfluff-darwin-arm64.tar.gz": "2a4848317c6bdd1896d38d4d890ca2736ec94f2b68955096e45329c7428182e7",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.1.1/sqlfluff-linux-amd64.tar.gz": "d9cc10862eba04af9a6bdf11e81731bc20828a64eff3f94664518022ea27dc8b",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.1.1/sqlfluff-linux-arm64.tar.gz": "70e48fab9c43e873ed50870ee8e39728fc2fe602221ea080814b78d090c50721",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.2.0/sqlfluff-darwin-amd64.tar.gz": "91de9d9fae860ce90d75d5de494029c889f4144d7e738f566936bd4d6b6923ff",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.2.0/sqlfluff-darwin-arm64.tar.gz": "4ad4b3efbbb9d81c718f6888190ddca78156b572c2f0aee18f27e98daa6f1b51",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.2.0/sqlfluff-linux-amd64.tar.gz": "e969b6695a99245946c78bbcabe7d20fbbef5b70e4b152ddfa4843ce3f5225e5",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.2.0/sqlfluff-linux-arm64.tar.gz": "810aee0c76225b1fb0e88c41a899721e40bd58388fa535206fab3aa9f8d9356e",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.2.1/sqlfluff-darwin-amd64.tar.gz": "2be442e3b6cbae7f4773341946442eecbeedd5c6898f0d18b87fc0dc42637c1d",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.2.1/sqlfluff-darwin-arm64.tar.gz": "39d0df7b3f71bbc4a7d9e53570266575bf7f0e37523ba4e7a9e74e6665a4af8d",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.2.1/sqlfluff-linux-amd64.tar.gz": "b009ea9edfa1e9620dc44775678defb44085296b1a9c9b0941bac1d84807a134",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.2.1/sqlfluff-linux-arm64.tar.gz": "92ff1407582551a8f6d263f663968c635d2d9d34971c53cb95313dfeeca914fc",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.2.2/sqlfluff-darwin-amd64.tar.gz": "b41f328c1608c6a3da2357ba6a0d0b516e89eb98af213aea49bb6f383336d934",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.2.2/sqlfluff-darwin-arm64.tar.gz": "5a9c13eed344b0a2e22db1283e3895576035932d7699f0bcf64cd2ebe6087477",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.2.2/sqlfluff-linux-amd64.tar.gz": "c47a54907ff9e35c1b13b61a42e7bb077682e91a161b90ec850e9d36e5a7cc8f",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.2.2/sqlfluff-linux-arm64.tar.gz": "38df4ead05130276b760c103157c029d5c37b986a5e602a76cfc1f7be6dd066b",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.2.3/sqlfluff-darwin-amd64.tar.gz": "096a3439d93224cf5fbf748a1bc5f98b44b613cbd7f234b0d1b3bf0888497a9b",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.2.3/sqlfluff-darwin-arm64.tar.gz": "9bddb65c0bf208cbfd7899f66c25b8c54bc2a468effcb8c3c7112c04a030350a",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.2.3/sqlfluff-linux-amd64.tar.gz": "c3fd79e339ed37847d3564621b02d4dc7a4327b18a1567ea1fad7ba71f58d298",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.2.3/sqlfluff-linux-arm64.tar.gz": "f848637dcb40e4913983b2898b8611580dda911b09c0d2829e5f341166abc49d",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.2.4/sqlfluff-darwin-amd64.tar.gz": "a73e683949ca090f6205ef5c6b14791c429409330220024db371b07dd4b50037",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.2.4/sqlfluff-darwin-arm64.tar.gz": "60ac2c9a2d91541ed47e3ce390039d4a9c8ab840ec12edfabbed699695217da7",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.2.4/sqlfluff-linux-amd64.tar.gz": "014b757a2c7acb38deb75cd5ce16db2e404f604c7d5cf6f2a704d9f2a0e8b7db",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.2.4/sqlfluff-linux-arm64.tar.gz": "e667af977ef2a72e21c4255d939ba8b37eb3ac42578aa4cbd441b40c7764b0b0",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.2.5/sqlfluff-darwin-amd64.tar.gz": "fe0bb58d85d230f3bdac0cd52dc792a8c9dd61f4c0dfe1df385cb2baa218d888",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.2.5/sqlfluff-darwin-arm64.tar.gz": "87860df025aabb6c016461d34a5a2fc269035c5049cbfd9eb06d36a741526be5",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.2.5/sqlfluff-linux-amd64.tar.gz": "73b0cde668048f68b6248aec5f066432312713f2fafc94197590dd6bb1c774fd",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.2.5/sqlfluff-linux-arm64.tar.gz": "c114554f4915314db2c14e9dc50d0305f58f8ece2f0805fe82bcc593282d12a1",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.3.0/sqlfluff-darwin-amd64.tar.gz": "fa8b3ef060bb6f45dfd022c15cf89d0e124166506c805bdd56822356cc032dc5",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.3.0/sqlfluff-darwin-arm64.tar.gz": "991d983278d73d7432dc0e280f2b1d1694dce125f54191bf09c639c610093b80",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.3.0/sqlfluff-linux-amd64.tar.gz": "9f370c39eda9180f95b5cc45e629c069d94fc9fcd878d58d44636a3ec0e84743",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.3.0/sqlfluff-linux-arm64.tar.gz": "fb5f7f5c87ba6b40c46b956cc1e635c6f42eb2e04e494a2ebe35c9e5aa774861",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.3.1/sqlfluff-darwin-amd64.tar.gz": "59b54d6056d70f6b45fe2afc41da42f5434ef7808211f00f6791ee48afcbeb75",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.3.1/sqlfluff-darwin-arm64.tar.gz": "d51ce89653033a1cb66d18b52450cfde761669459f883b60d6654951bab9ae9e",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.3.1/sqlfluff-linux-amd64.tar.gz": "8025f6c23f0cdf65c831c3d8c7ad7f6bcc9e343da47dcc06730d19ace9226ca3",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.3.1/sqlfluff-linux-arm64.tar.gz": "e0389dc3dbdec63ebfd85e1b962c6d9de59cb27c7fe743ff75d124863612b83d",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.4.0/sqlfluff-darwin-amd64.tar.gz": "49ed85cb50e41de817b6b60906dea34f5245de2d3ad708e63fe0d071011a5de4",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.4.0/sqlfluff-darwin-arm64.tar.gz": "53d8317d4c0c9a684375f33b61ffd7b94ae171cb32a4d0ebe35696897d274b14",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.4.0/sqlfluff-linux-amd64.tar.gz": "b02cfdd46b9ba1927abd6a8bd3a3f41f40a477d83b53ab9f13e048d3652560a1",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/sqlfluff-v3.4.0/sqlfluff-linux-arm64.tar.gz": "fdbba59103d8614250075911b1b84a55e79234fe4b87f1e685abb231e6d2ebea",
}