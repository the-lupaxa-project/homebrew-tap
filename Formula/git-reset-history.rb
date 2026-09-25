class GitResetHistory < Formula
  desc "Bash CLI to flatten a Git repository to a single initial commit, with dry-run, backups, and controlled tag handling"
  homepage "https://github.com/lupaxa-git-toolbox/git-reset-history"
  url "https://github.com/lupaxa-git-toolbox/git-reset-history/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "71728fda4283d7ddff7ee05789452075f237b5ec8ff34b8b1e99828fe5c2f750"
  license "MIT"

  def install
    bin.install "src/git-reset-history"
  end

  test do
    assert_match "Rewrite a Git repository down to a single initial commit", shell_output("#{bin}/git-reset-history --help")
  end
end
