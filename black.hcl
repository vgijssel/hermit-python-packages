description = "The uncompromising Python code formatter"
binaries = ["black", "blackd"]
test = "black --help"
repository = "https://github.com/vgijssel/hermit-python-packages"
source = "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v${version}/black-${os}-${arch}.tar.gz"

version "25.9.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "25.1.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "24.8.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "24.4.2" {
  runtime-dependencies = ["python3@3.11"]
}
version "24.4.1" {
  runtime-dependencies = ["python3@3.11"]
}
version "24.4.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "24.3.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "24.2.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "24.10.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "24.1.1" {
  runtime-dependencies = ["python3@3.11"]
}
version "24.1.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "23.9.1" {
  runtime-dependencies = ["python3@3.11"]
}
version "23.9.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "23.7.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "23.3.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "23.12.1" {
  runtime-dependencies = ["python3@3.11"]
}
version "23.12.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "23.11.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "23.10.1" {
  runtime-dependencies = ["python3@3.11"]
}
version "23.10.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "23.1.0" {
  runtime-dependencies = ["python3@3.11"]
}
version "22.12.0" {
  runtime-dependencies = ["python3@3.11"]
}

sha256sums = {
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v22.12.0/black-darwin-amd64.tar.gz": "f64bfac87eea3533afee6eb2ce59869bf54221435cbef12ab04704293c1995e7",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v22.12.0/black-darwin-arm64.tar.gz": "1c692bd3f66795680fedca9e23fa82245b30a0ccf53a03c8347f7b13d2ea33f1",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v22.12.0/black-linux-amd64.tar.gz": "4f1d3631431f3b8c75ddaf6b28f4e20319a74d6935998843101e1d3d07947e32",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v22.12.0/black-linux-arm64.tar.gz": "a3450c314a2c5b467936492b614c9cf793e614265ff46126b34eb6badc607204",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.1.0/black-darwin-amd64.tar.gz": "1946b4a2d543485214779f80b3d4c46f2b1f2ca7789998840ba31e1109d65617",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.1.0/black-darwin-arm64.tar.gz": "64669e489d72384238d692cc8629551a03bd550996d4da313365e346e8f37470",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.1.0/black-linux-amd64.tar.gz": "fbea82db9194df24d7fc239fec461cc9341c3a6630d10a3fdf703ce89d565121",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.1.0/black-linux-arm64.tar.gz": "0c1829c2f4b755ab303dffe50019a88afeabaf929651f39f784883ed5fb949f6",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.10.0/black-darwin-amd64.tar.gz": "5314e9304d0b3eb5e82b37a97f44b66193c1d8702f3ae68f87f06c1da3807b91",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.10.0/black-darwin-arm64.tar.gz": "4286f57bf0c3cd7af0a880e6573640506b92714eced9d450d28ba18632a77dff",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.10.0/black-linux-amd64.tar.gz": "6237283e7ed37ca7ea73ab1ca8f2a081aacd5c4ff977c388ec5e6cc46d63b5af",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.10.0/black-linux-arm64.tar.gz": "52bd2876b26b2c952d780e121b4d6f012a263109033cabf2be7e499f40ca518f",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.10.1/black-darwin-amd64.tar.gz": "7a78955becc022860372d5fb129a5dd96b2a9735ccb907ea6200a9c5b7a39461",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.10.1/black-darwin-arm64.tar.gz": "e8efb7722810084b1e4204e844cfdf8a6ede1eed72a06c6ae628d2380ba57578",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.10.1/black-linux-amd64.tar.gz": "17f73f747a74378ddcd51a8c6cc833ccef3c6f81e794fb8b00de639a09c8ff19",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.10.1/black-linux-arm64.tar.gz": "12dea8c9d34932aae4848f223b9765cc16f39170fca6da18874655432441ad84",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.11.0/black-darwin-amd64.tar.gz": "e8ef8326ef457901691009fd6ebf1ba9f6c99480c4646fce40a7511065ac6dcc",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.11.0/black-darwin-arm64.tar.gz": "e0e7c81168953b1e8c0ec72b0a8f060d05483272f64a8b44fea80aefe1010d14",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.11.0/black-linux-amd64.tar.gz": "a8cd6052118f5a8869d0c1d2a149a187cfe8efcb1b0471defea85ff4e90c7292",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.11.0/black-linux-arm64.tar.gz": "41204855e84e190fbaf88538bc241d1ea62506de5b5844199648ccdcbb698cd0",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.12.0/black-darwin-amd64.tar.gz": "356bc4e68b390070ab189a7a9ccbb05fa7973aebb8298790ba6d7a2f50053441",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.12.0/black-darwin-arm64.tar.gz": "72e0e0d633dde9a21aaf07fb24b51b5111f091783df348ad00fc4ef7cc13b385",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.12.0/black-linux-amd64.tar.gz": "f22eed1b9a3530d5581404264af7481db23992a025f3a07a6e6b767e1d8e8056",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.12.0/black-linux-arm64.tar.gz": "c10f23b84d91896edb3ebc123891429692f7ebbd708ee48e74507df8d0a6b94a",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.12.1/black-darwin-amd64.tar.gz": "0403df844702c4e5be21bf49157f231da7d33497fcf43d17851af9034f78d062",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.12.1/black-darwin-arm64.tar.gz": "fe251f9de645b5d4d2be07cf9fb10f17d86fc5f759d45c1411b55952d581a893",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.12.1/black-linux-amd64.tar.gz": "bef77e3d3427c463a2efb5ac89b8ae0ab01af36a40d6b6ea318fc2bd4bbed965",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.12.1/black-linux-arm64.tar.gz": "b660883ea91edcb1b9fe98bb36b505d6c843ed4e72c1a8276064c88ffca66db4",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.3.0/black-darwin-amd64.tar.gz": "c4d163cc5b9e3b31a8ced584e7ee06d61ad9981b761d136c0d66adcc765f13e5",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.3.0/black-darwin-arm64.tar.gz": "b530a608ac32218507a6a4981b0d2064e9f640b7617ebf55cb4010ad73afc793",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.3.0/black-linux-amd64.tar.gz": "01f078c20e95235e492265e25a8fed7ce5843e0fd2f400d14dfb862708074dbc",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.3.0/black-linux-arm64.tar.gz": "701c467dc9ca3f010ed4d524c489793ed8d108bbd8e4a9e7b7a9b0622bdf3cce",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.7.0/black-darwin-amd64.tar.gz": "bd2e7bdf3c66c8cd11cc3c2a1c71132a77da37f1b001bc4c45d94584e5ff4ab0",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.7.0/black-darwin-arm64.tar.gz": "259bf00226c306191112dd4af6e21466f7028cce27223ad0999f5417d31106e7",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.7.0/black-linux-amd64.tar.gz": "fa0c25e5963278201a8616c78df670d83feaff2388499e6e9ca9cadeb96c55b5",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.7.0/black-linux-arm64.tar.gz": "1771ee8bd1738aa35b9126c1ed6b2a72794ed444a1fb6577715d40e03efbc644",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.9.0/black-darwin-amd64.tar.gz": "d9de3a7161acfc1954760476e4f728bd521ed7f4c876815a2de6b8f94df4c98d",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.9.0/black-darwin-arm64.tar.gz": "af8dc3f224678a116bcd43e40c578f68e8b0895528f0391035570e463f381670",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.9.0/black-linux-amd64.tar.gz": "b45d81631804020bf048ef0978f0ab5271aec54fd1854421563b244fb86e5fa8",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.9.0/black-linux-arm64.tar.gz": "736bfe9853bc6023e94fa5160eee7df82f5e5fc99d369fbe5381127ec8a0362c",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.9.1/black-darwin-amd64.tar.gz": "4a68b4e0510676f6ff4dc08d529da8beb302936a2f851c93fda217d86b1463f5",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.9.1/black-darwin-arm64.tar.gz": "0206568574f4594141d0849455cac455c338a96354c90ef856b86ac2a366e8ab",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.9.1/black-linux-amd64.tar.gz": "339f8fcc336c4470a979424997586b7634c8c5ff53d3045e30f44753ebcd9623",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v23.9.1/black-linux-arm64.tar.gz": "da226e0ff78abacfaa02d19ffcd4bc55feefec712e8326b52ca87169cbf90eb1",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v24.1.0/black-darwin-amd64.tar.gz": "d12fb5e15a0f7ded745f1de7449d4d373924773e58263d930aaaafa160e73475",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v24.1.0/black-darwin-arm64.tar.gz": "82ecf3d8d5f9064a053b494b23e8def4aee56a57574842d129005fa310c0cc3c",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v24.1.0/black-linux-amd64.tar.gz": "cc7fa7c2ed51e1052f0bbfeb047a5d79aeed4579ccc61470b0380f7a573cd31b",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v24.1.0/black-linux-arm64.tar.gz": "cc08b774c6dcfc642fd51c086d0e731cd200c9c491afc3ad7b853832f7ee91c4",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v24.1.1/black-darwin-amd64.tar.gz": "2e0eb8c17bc50b6b3a731da299bf03da81ad65924bbaeb28e65ec220e51d107e",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v24.1.1/black-darwin-arm64.tar.gz": "4c216365042c9d8585cdc493b506394d95a40ca279f416d827181b945b199b59",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v24.1.1/black-linux-amd64.tar.gz": "82cc8c8d1bce8c00095c5a19a62c22387accc29101b15e643469c41bbd10e8b6",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v24.1.1/black-linux-arm64.tar.gz": "660adba6bc24b8d8c188993a4e67373a842d1061862252eb4ddc147f000425bc",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v24.10.0/black-darwin-amd64.tar.gz": "98bef7c282dccabcb88c3b236e200cbb40b6d8fcf544f1277e02f1129e97e016",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v24.10.0/black-darwin-arm64.tar.gz": "27680f3cb6eb8a953d36e8ddaf8c0202012b146a9c55ef23fea9f01532beca8f",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v24.10.0/black-linux-amd64.tar.gz": "3c24e6fde01ccef630e6bf269b3c696ff783c44d896b772018b897d9405141ba",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v24.10.0/black-linux-arm64.tar.gz": "268e6ca4043d5e9a165d6ffe60e9c2b8c9f46167fb4672af65684ebc6a28de80",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v24.2.0/black-darwin-amd64.tar.gz": "6f789c5b735e102c983ce83b7cac86f5ed53b6c011b9229a3ac05f1a2956eabc",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v24.2.0/black-darwin-arm64.tar.gz": "8de485875edb562ce2f453e7503fa2468d21fe40ee4df82a623c4f79897efe08",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v24.2.0/black-linux-amd64.tar.gz": "ad2d01c30a3f35914020d71a84199667338f9df873286af1344dacbc1d831a2f",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v24.2.0/black-linux-arm64.tar.gz": "b016536649183547c8c29cddeed7137a9e8383b2a4e4585b991183161ef77709",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v24.3.0/black-darwin-amd64.tar.gz": "29714e1158c7cc6e58fc31b84ecb395281531b599247dbde72532e333135c766",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v24.3.0/black-darwin-arm64.tar.gz": "c04c70940e035ab1ca3b8b62416f1ce3727f2889920164e24833a50aa37e0ae1",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v24.3.0/black-linux-amd64.tar.gz": "130870ac01db39c7fd941a5d9cfcc172f28ccc48d140ba3ed7d8210c583fbd24",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v24.3.0/black-linux-arm64.tar.gz": "ed6574c1c2efc6a8ea1644cfb891c033a4369509f0b553e2ea3a59ec6f303fe8",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v24.4.0/black-darwin-amd64.tar.gz": "bbc7fdc8b05a53070e632e997b60bc05c121b7c3499e9fc698eac6ddaa2a1b8d",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v24.4.0/black-darwin-arm64.tar.gz": "b23e96fa26436da56df14c824ce9c2bae410ab65c11974d33914007ce747f0ff",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v24.4.0/black-linux-amd64.tar.gz": "700d1156e66dc63794cef6129afdc7aa88ff35be9982567e093d6f540594fb5c",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v24.4.0/black-linux-arm64.tar.gz": "1563a9842896d07d4e77fcbdc9ac0ae83efa2c64abb0e89aee3b409634f1783c",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v24.4.1/black-darwin-amd64.tar.gz": "bc8bbc7ca1d278c6de420bb7c643bc5b76ba4fe1caf9d1a7d97c37989a96e6ff",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v24.4.1/black-darwin-arm64.tar.gz": "589616bd66a18e885619253ba18a6f66793eab836a38f37d99126b6a43001265",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v24.4.1/black-linux-amd64.tar.gz": "f5e83374458c835fd5108f89d79b78fbe8e70ecb2cee735e6d1fd2455a2d6bb8",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v24.4.1/black-linux-arm64.tar.gz": "4442632c2e1df22590c79f512a084cbf261c5f57ade0b7daa9f1e11d8699557a",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v24.4.2/black-darwin-amd64.tar.gz": "57c2acf38abfc5d03f16abe423b84b149b2079b920aa19a024760db9435cced3",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v24.4.2/black-darwin-arm64.tar.gz": "923d9357df6c5e4fd1dc7b7793f8dd80f1121db416666eba4bf17f8aa6076a44",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v24.4.2/black-linux-amd64.tar.gz": "1ab749685d4efbe77fba28810203e22b3052dbfb8d3996b040f217739b978fe0",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v24.4.2/black-linux-arm64.tar.gz": "b31ae2ededcf778047e72eb00618887d3fd2ccb761a044bee3e3ef552229aba2",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v24.8.0/black-darwin-amd64.tar.gz": "d3105132f5897de4ba6edc5ca952898719834397869ec6dac0a5b3cc283ef4d9",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v24.8.0/black-darwin-arm64.tar.gz": "70234f471823e115b0fe64ee83d1235784c760ef93eb651fcd8bde77f4cca14b",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v24.8.0/black-linux-amd64.tar.gz": "275d907b0f2990c0070a5ef45b949252184429c7bd0f3941f2da43745b536f30",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v24.8.0/black-linux-arm64.tar.gz": "146baf9666e999adf49bf461f41286a9f2e3bc79f31adc1a884aa6a3c67b76f9",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v25.1.0/black-darwin-amd64.tar.gz": "d9d9a343f2b81b906e4a71a31bb871da1fbec791bc6750a06ab268dae3bf24f0",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v25.1.0/black-darwin-arm64.tar.gz": "d03562f6137532e2cafd24af091e124b2b2947d787c6e686c5bf4486af0ad0bd",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v25.1.0/black-linux-amd64.tar.gz": "443727303f76e04460fa548cbcd990d66abe7aada443f37e5342fc6ad6a5dcc5",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v25.1.0/black-linux-arm64.tar.gz": "c1f15d9fe07193cddd7183daabbea808b932fbe51bb7d96804a3fcd8c19b7927",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v25.9.0/black-darwin-amd64.tar.gz": "3b1502c4d8688e2af2da9f43bbcec69cd7005f529790839dcfe8a2d30ec02863",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v25.9.0/black-darwin-arm64.tar.gz": "f628c7b4af7088514b3af93a3774410ea27e138f482f0a39724154244bb0ece3",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v25.9.0/black-linux-amd64.tar.gz": "2d9116de45d45efdfefbbf2e48fc0eacf150221050efd8311826606cbed33a48",
  "https://github.com/vgijssel/hermit-python-packages/releases/download/black-v25.9.0/black-linux-arm64.tar.gz": "4e3315ef2b5c396e15c8aa78a9e4c4a4925a0ab7dbc868e15b2d19b6630782ee",
}