class EveryRepo < Formula
  desc "Bash CLI to run a command, file, or script in every Git repository under a path"
  homepage "https://github.com/lupaxa-git-toolbox/every-repo"
  url "https://github.com/lupaxa-git-toolbox/every-repo/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "d7f95a7361ac60d7aeb171e786390eb3b12e5e00fa0a244a470fa7b84673275b"
  license "MIT"

  def install
    bin.install "src/every-repo"
  end

  test do
    assert_match "every-repo [options] <path> --command", shell_output("#{bin}/every-repo --help")
  end
end
