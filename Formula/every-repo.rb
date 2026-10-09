class EveryRepo < Formula
  desc "Bash CLI to run a command, file, or script in every Git repository under a path"
  homepage "https://github.com/lupaxa-git-toolbox/every-repo"
  url "https://github.com/lupaxa-git-toolbox/every-repo/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "c22e489dff09e3b22c6c21d667ca1c276c9f50cec1d07aaad9eb3d7a548ee325"
  license "MIT"

  def install
    bin.install "src/every-repo"
  end

  test do
    assert_match "every-repo [options] <path> --command", shell_output("#{bin}/every-repo --help")
  end
end
