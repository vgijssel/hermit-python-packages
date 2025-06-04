description = "Wait for service(s) to be available before executing a command."
binaries = ["wait-for-it"]
test = "wait-for-it --help"
repository = "https://github.com/vgijssel/hermit-python-packages"
source = "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v${version}/wait-for-it-${os}-${arch}.tar.gz"

version "2.3.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "2.2.2" {
  runtime-dependencies = ["python3@3.11"]
}
version "2.2.1" {
  runtime-dependencies = ["python3@3.11"]
}
version "2.2.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "2.1.1" {
  runtime-dependencies = ["python3@3.11"]
}
version "2.1.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "2.0.1" {
  runtime-dependencies = ["python3@3.11"]
}
version "2.0.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "1.1.2" {
  runtime-dependencies = ["python3@3.11"]
}
version "1.1.1" {
  runtime-dependencies = ["python3@3.11"]
}
version "1.1.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "1.0.2" {
  runtime-dependencies = ["python3@3.11"]
}
version "1.0.1" {
  runtime-dependencies = ["python3@3.11"]
}
version "1.0.0" {
  runtime-dependencies = ["python3@3.11"]
}

sha256sums = {
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v1.0.0/wait-for-it-darwin-amd64.tar.gz": "e1ce754d5bd6102e044ee7154860493ecd28bc207b96e59d5dd469de972cd370",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v1.0.0/wait-for-it-darwin-arm64.tar.gz": "d015424124a72e406c3bdaa7c8a4766aae8856dcc5d962b0d29ea2f799056e82",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v1.0.0/wait-for-it-linux-amd64.tar.gz": "2ad4d6846c820a3911ae58c1b2b0845f29249989cc767cfdd1c0105126cae881",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v1.0.0/wait-for-it-linux-arm64.tar.gz": "9191a3fcb051dc5b143f9dfbc3c0e215849fed2ab0b5dc5d386eff7da1294185",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v1.0.1/wait-for-it-darwin-amd64.tar.gz": "1337a32bdcb08cc6a70a13f63ac3cd0fbe942b78d4919328f3f1cf7a8aed42d5",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v1.0.1/wait-for-it-darwin-arm64.tar.gz": "1c02ef1dec1729d973d447a76cb7fce49da36a39f4cc34fe914c910c21b161d6",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v1.0.1/wait-for-it-linux-amd64.tar.gz": "ba1a36e591638ce94846376be5b3fddbaa1c1e40064e529cc4fb80599fd18bb8",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v1.0.1/wait-for-it-linux-arm64.tar.gz": "9b63fd1f7a6d56c81ec55cec78ed93f4a169f31586b2cd15f29bc7546cf558bd",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v1.0.2/wait-for-it-darwin-amd64.tar.gz": "9477de4b929bbdbc5a0d9b09888d2566e90926c83aeed33f7e995feb51fcb7e8",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v1.0.2/wait-for-it-darwin-arm64.tar.gz": "8b4a7d91155d1cf3c2439063177d0d4af7706686338404a4693a0e459a74fb6e",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v1.0.2/wait-for-it-linux-amd64.tar.gz": "c8c1f4768ac342d2dc072d5c8db0b09c131dfcf0394766810378197182084c6a",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v1.0.2/wait-for-it-linux-arm64.tar.gz": "bcaa738c3b5ddc1a1e1a949b48a88f4017075a5d1152f7566f18fcf96fbec01c",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v1.1.0/wait-for-it-darwin-amd64.tar.gz": "1bfece17e3eb0b8c5146b81960902717d0d4a263d19c0c90af7527eca6c9569f",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v1.1.0/wait-for-it-darwin-arm64.tar.gz": "6e5c0341f272fc451d14a96a0b461ddd586894d705f96b0acb421afd6968a3e3",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v1.1.0/wait-for-it-linux-amd64.tar.gz": "8484f4fa588129c594f8a1c19c949e44c9e0516bfd12b66bf8ac7a79b9896c8e",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v1.1.0/wait-for-it-linux-arm64.tar.gz": "b80ba2fdc99d8e71d5d655c377dcc4d24b4b7de8de4832a5b8e0026b90576d1f",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v1.1.1/wait-for-it-darwin-amd64.tar.gz": "aee4a016dd596f147055ef6e9d45a9e1a87f42c55a50590ee046885c18ec4ea9",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v1.1.1/wait-for-it-darwin-arm64.tar.gz": "8dc578be9e26bc19bc08cc170846500556f8d81d89b934c3346eec5c470d408c",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v1.1.1/wait-for-it-linux-amd64.tar.gz": "1cecbed4c54bedd6761df0fc6f9333669763b89cce370791a64f79bd7b0ead9c",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v1.1.1/wait-for-it-linux-arm64.tar.gz": "431db9682677cf482f0c4b07da2dded507621f270c097660b9d84af58db4db9b",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v1.1.2/wait-for-it-darwin-amd64.tar.gz": "0a2377d15b33060e8a39e58f50332cae2a66f46fa1e8b1585ec56a1913669f5e",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v1.1.2/wait-for-it-darwin-arm64.tar.gz": "7bcb546da23b7161e0e84ba04edfa4bd474c7d272d57071767305ce9793398c6",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v1.1.2/wait-for-it-linux-amd64.tar.gz": "be1ce6c2081fcca99eb8ccfc006e463a76af4ae1dfa2db59f1f79ff5435f2f00",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v1.1.2/wait-for-it-linux-arm64.tar.gz": "824eae7bcaa7a83166466753e7a6fdd0f26398862a2d6ed6ea7bbbdb84f09e0d",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v2.0.0/wait-for-it-darwin-amd64.tar.gz": "33e5af40be066bf2d37660f6d4c098b6e1191876ff891e6e6d5e18dd91c458fe",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v2.0.0/wait-for-it-darwin-arm64.tar.gz": "5ae1aee3531ebe2ce5a59f9f6ee02ca4d193fd4009d65da4622aebdbdda31cd1",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v2.0.0/wait-for-it-linux-amd64.tar.gz": "fc3cae546ecadf68137da24ebefb50e58b8465eef1043c87e39f3df0538d49f6",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v2.0.0/wait-for-it-linux-arm64.tar.gz": "f172716c892ad1c7c5c19012c9f9ffa99a72d1e8e298a1fef8fc25f7a6e1b99c",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v2.0.1/wait-for-it-darwin-amd64.tar.gz": "d0d1a308c74740a144b6cbb349c0bae0929bf054778a85ea9c75c5e62255be5a",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v2.0.1/wait-for-it-darwin-arm64.tar.gz": "b79bafcf76557336f2bf05c30ded43a6c45439bf66580d3925f806f9a774e543",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v2.0.1/wait-for-it-linux-amd64.tar.gz": "5a753513bf2e3f35b65e5ad946c1ed2aef280ec8cc58f2a5d442e8846915028d",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v2.0.1/wait-for-it-linux-arm64.tar.gz": "392b005d2635149d380b551db5d24dcc038474fefd6d732ca0f821d5e3b8a4c2",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v2.1.0/wait-for-it-darwin-amd64.tar.gz": "24b23dc25bdb3e8c96131d31a7e82c984e7c369c8fdd84fbb89b9daeeee2aebf",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v2.1.0/wait-for-it-darwin-arm64.tar.gz": "cebb156c8dbed0fd7afc2c9287e5f20c83d471e2d9c6de4cdd7fde0cc8024261",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v2.1.0/wait-for-it-linux-amd64.tar.gz": "d9ca13482455fefb715265d495a7ff635f654cd17d746def28b9c86e8e84f8af",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v2.1.0/wait-for-it-linux-arm64.tar.gz": "65143535228e25ef6578a8b4068455e6677ec4794c048f76a721623521cb1a2c",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v2.1.1/wait-for-it-darwin-amd64.tar.gz": "0f18fca1b8c8dc3068eabf2e02c389662cc60099e78ac1a774a4dda0fb772d6f",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v2.1.1/wait-for-it-darwin-arm64.tar.gz": "c13868a818812fd7a3a4a0cad7158711ab6bda64932100aac516a38d74b1086e",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v2.1.1/wait-for-it-linux-amd64.tar.gz": "2f9de8ef359f40a58aa6c376b144f637192869ec7d6bfdb15b27a06d0fe3c882",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v2.1.1/wait-for-it-linux-arm64.tar.gz": "bfd1aa9cf151fb41cb604dcf663a93e3fde1a554d49f88a17f88fcdbbb2c647c",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v2.2.0/wait-for-it-darwin-amd64.tar.gz": "040ecf32c47a066d427491ea17bb6d78a8cce75cd3c3b7d66b6776e998aca1d4",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v2.2.0/wait-for-it-darwin-arm64.tar.gz": "52639421c84928a88e619928d805eed2292c6d1a69ce5f7a7d45dd111fc539e2",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v2.2.0/wait-for-it-linux-amd64.tar.gz": "da8689136b80ede0cfaec41c0ecde7a43eaf0f5888fda935914cab09f68824e1",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v2.2.0/wait-for-it-linux-arm64.tar.gz": "1552171432594588904b6a03f328639d26be49db61e8ae8630f71fe675db53c3",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v2.2.1/wait-for-it-darwin-amd64.tar.gz": "bd9cbeccad09642c02a91a1a87b1978b95b66a43f741ba78f75c08e47cc4e2e5",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v2.2.1/wait-for-it-darwin-arm64.tar.gz": "db3899ea8e588c8d87867ad7a7582ae4cd79311e0341850d83aba9e14393ca03",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v2.2.1/wait-for-it-linux-amd64.tar.gz": "2fd52a716dd6f8e0cff4d96580a1f0c94545c07ca8066130ae6af1f652482f9b",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v2.2.1/wait-for-it-linux-arm64.tar.gz": "bd528f8688e6170f7bb31fe440bfeb5a961718e51c90b4ac48949281d34e2367",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v2.2.2/wait-for-it-darwin-amd64.tar.gz": "f55f69d9295477ef23ca4aabd78c5b4ce757d6675206bdc5cc9fd896906d1389",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v2.2.2/wait-for-it-darwin-arm64.tar.gz": "37b8fec7166901dc0951ba33b4112f4cf599404a7ef40f0956affb6c326fd83f",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v2.2.2/wait-for-it-linux-amd64.tar.gz": "f53201c67529d6a1104d9db23f3a84f3588b8b613585430240bd6151b1d59723",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v2.2.2/wait-for-it-linux-arm64.tar.gz": "d18775c52e44cde888595e74ea0a62ac987ffc3257549baf583f183485935b37",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v2.3.0/wait-for-it-darwin-amd64.tar.gz": "d3ff89a1d915511930a3ba7a4165a06975af6bda70d4cbb012d56723c193b052",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v2.3.0/wait-for-it-darwin-arm64.tar.gz": "87bde7aa08bf507c624de936120c635ea1c3e581a6fa72d3012bea8d2c487995",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v2.3.0/wait-for-it-linux-amd64.tar.gz": "40a3fb65ca35caa17ae1ede5cd3ba3e285f9ba5704045a1cf1b18b1fe06696d1",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/wait-for-it-v2.3.0/wait-for-it-linux-arm64.tar.gz": "d3de1cc523526d342a23a7616c1a00635f9b9b19e0847c1c6ff9d73ef73303a0",
}