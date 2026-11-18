class ContainerManager < Formula
  desc "Manage Docker images and containers on this machine: list them, delete them, and purge unused ones"
  homepage "https://github.com/lupaxa-docker-toolbox/container-manager"
  url "https://github.com/lupaxa-docker-toolbox/container-manager/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "b41c73b300d1eea6f1cb55249b6441893aa90cb7cab90af1bd1276819cea521a"
  license "MIT"

  def install
    bin.install "src/container-manager"
  end

  test do
    assert_match "Usage: container-manager [options]", shell_output("#{bin}/container-manager --help")
  end
end
