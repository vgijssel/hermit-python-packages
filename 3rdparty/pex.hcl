description = "A tool for generating .pex (Python EXecutable) files, lock files and venvs."
binaries = ["pex"]
test = "pex --help"
runtime-dependencies = ["python3@3.13"]
repository = "https://github.com/pex-tool/pex"

darwin {
  source = "https://github.com/pex-tool/pex/releases/download/v${version}/pex-macos-${xarch}"

  on "unpack" {
    rename {
      from = "${root}/pex-macos-${xarch}"
      to = "${root}/pex"
    }

    chmod {
      file = "${root}/pex"
      mode = 493
    }
  }
}

linux {
  source = "https://github.com/pex-tool/pex/releases/download/v${version}/pex-linux-${xarch}"

  on "unpack" {
    rename {
      from = "${root}/pex-linux-${xarch}"
      to = "${root}/pex"
    }

    chmod {
      file = "${root}/pex"
      mode = 493
    }
  }
}

version "2.38.0" {
  auto-version {
    github-release = "https://github.com/pex-tool/pex"
  }
}

sha256sums = {
  "https://github.com/pex-tool/pex/releases/download/v2.38.0/pex-linux-x86_64": "03db7bd44c239cfd0c01cc13d96498054996f6146156d33a3de92d448de8ac2f",
  "https://github.com/pex-tool/pex/releases/download/v2.38.0/pex-macos-x86_64": "6707c57326b640a7856c35957e08a817f114ffdaaee54a6e66eafae95c2c23bd",
  "https://github.com/pex-tool/pex/releases/download/v2.38.0/pex-macos-aarch64": "9a64a7b69a29346a943fb66494b6307c81ec9a36032fe1974824b2ece81edc4f",
  "https://github.com/pex-tool/pex/releases/download/v2.38.0/pex-linux-aarch64": "60dfa8f705d736a4a60b6f8321ee537d77a5fbc94f7cd92ef697d9272df67776",
}
