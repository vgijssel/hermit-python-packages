description = "Python tool aider-chat packaged as PEX"
binaries = ["aider-chat"]
test = "aider-chat --help"
repository = "https://github.com/hermit-python-packages/hermit-python-packages"
source-repo = "https://github.com/paul-gauthier/aider"

darwin {
  source = "oci://ghcr.io/hermit-python-packages/aider-chat:${version}-${python-version}-darwin"
}

linux {
  source = "oci://ghcr.io/hermit-python-packages/aider-chat:${version}-${python-version}-linux"
}

on "unpack" {
  rename {
    from = "${root}/app/aider-chat"
    to = "${root}/aider-chat"
  }
  
  chmod {
    file = "${root}/aider-chat"
    mode = 493  # 0755 in octal
  }
}

version "0.80.0" {
  python-version = "py3.11"
}

version "0.82.0" {
  python-version = "py3.12"
}
