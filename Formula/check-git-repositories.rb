class CheckGitRepositories < Formula
  desc "Bash CLI to scan a directory tree for Git repos and report unclean or unsynced state"
  homepage "https://github.com/lupaxa-git-toolbox/check-git-repositories"
  url "https://github.com/lupaxa-git-toolbox/check-git-repositories/archive/refs/tags/v0.1.7.tar.gz"
  sha256 "84bba65b7dc38237b8011d340d46ad7142ac748728e3f507a342f16713f9e4cb"
  license "MIT"

  def install
    bin.install "src/check-git-repositories"
  end

  test do
    assert_match "Usage: check-git-repositories", shell_output("#{bin}/check-git-repositories --help")
  end
end
