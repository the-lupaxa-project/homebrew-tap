class CheckGitRepositories < Formula
  desc "Bash CLI to scan a directory tree for Git repos and report unclean or unsynced state"
  homepage "https://github.com/lupaxa-git-toolbox/check-git-repositories"
  url "https://github.com/lupaxa-git-toolbox/check-git-repositories/archive/refs/tags/v0.1.5.tar.gz"
  sha256 "932108cddbe38d6b4a0054647e6b56ba9cf786b5f23342c4b2c6be1fef71e99c"
  license "MIT"

  def install
    bin.install "src/check-git-repositories"
  end

  test do
    assert_match "Usage: check-git-repositories", shell_output("#{bin}/check-git-repositories --help")
  end
end
