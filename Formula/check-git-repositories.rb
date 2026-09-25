class CheckGitRepositories < Formula
  desc "Bash CLI to scan a directory tree for Git repos and report unclean or unsynced state"
  homepage "https://github.com/lupaxa-git-toolbox/check-git-repositories"
  url "https://github.com/lupaxa-git-toolbox/check-git-repositories/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "6af9224c629084382686e7e4a951ae12605424f4dc0bbe098e5b8219dc38758e"
  license "MIT"

  def install
    bin.install "src/check-git-repositories"
  end

  test do
    assert_match "Usage: check-git-repositories", shell_output("#{bin}/check-git-repositories --help")
  end
end
