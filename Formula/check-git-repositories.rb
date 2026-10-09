class CheckGitRepositories < Formula
  desc "Bash CLI to scan a directory tree for Git repos and report unclean or unsynced state"
  homepage "https://github.com/lupaxa-git-toolbox/check-git-repositories"
  url "https://github.com/lupaxa-git-toolbox/check-git-repositories/archive/refs/tags/v0.1.8.tar.gz"
  sha256 "f7e416bfa2a488cbdd62769edb725e9d4e811187555719b10cc06bddf929300d"
  license "MIT"

  def install
    bin.install "src/check-git-repositories"
  end

  test do
    assert_match "Usage: check-git-repositories", shell_output("#{bin}/check-git-repositories --help")
  end
end
