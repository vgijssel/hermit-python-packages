description = "Protects your Pants from the elements."
binaries = ["pants"]
test = "pants --help"
runtime-dependencies = ["python3@3.13"]
dont-extract = true
source = "https://github.com/pantsbuild/scie-pants/releases/download/v${version}/scie-pants-${os}-${xarch}"

linux {
  source = "https://github.com/pantsbuild/scie-pants/releases/download/v${version}/scie-pants-linux-${xarch}"

  on "unpack" {
    rename {
      from = "${root}/scie-pants-linux-${xarch}"
      to = "${root}/pants"
    }

    chmod {
      file = "${root}/pants"
      mode = 493
    }
  }
}

darwin {
  source = "https://github.com/pantsbuild/scie-pants/releases/download/v${version}/scie-pants-macos-${xarch}"

  on "unpack" {
    rename {
      from = "${root}/scie-pants-macos-${xarch}"
      to = "${root}/pants"
    }

    chmod {
      file = "${root}/pants"
      mode = 493
    }
  }
}

version "0.12.3" {
  auto-version {
    github-release = "pantsbuild/scie-pants"
  }
}

sha256sums = {
  "https://github.com/pantsbuild/scie-pants/releases/download/v0.12.3/scie-pants-linux-x86_64": "816ee23d7d68283ee2ff754eaba730a6f50e52a6026527516ab25204c2a50539",
  "https://github.com/pantsbuild/scie-pants/releases/download/v0.12.3/scie-pants-macos-x86_64": "1f0ce6ef37903935a2e2c2b01655a5fda4ac6b4ad7b529cb83bda3e341095296",
  "https://github.com/pantsbuild/scie-pants/releases/download/v0.12.3/scie-pants-macos-aarch64": "e68f6a3e3136e82181460cfc7e0dbf2b453f7927b42c88f22be68b34acc76748",
  "https://github.com/pantsbuild/scie-pants/releases/download/v0.12.3/scie-pants-linux-aarch64": "120bea969a5c9f9b97c3c8222670ed3fb16c1a46f325fce2d6abbeac8cdd4a95",
}