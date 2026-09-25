class GitResetHistory < Formula
  desc "Bash CLI to flatten a Git repository to a single initial commit, with dry-run, backups, and controlled tag handling"
  homepage "https://github.com/lupaxa-git-toolbox/git-reset-history"
  url "https://github.com/lupaxa-git-toolbox/git-reset-history/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "8c4fd7e5e33410735f2e5adefa10fd6b83f2e83db269402947418e7ccb69851a"
  license "MIT"

  def install
    bin.install "src/git-reset-history"
  end

  test do
    assert_match "Rewrite a Git repository down to a single initial commit", shell_output("#{bin}/git-reset-history --help")
  end
end
