class GitResetHistory < Formula
  desc "Bash CLI to flatten a Git repository to a single initial commit, with dry-run, backups, and controlled tag handling"
  homepage "https://github.com/lupaxa-git-toolbox/git-reset-history"
  url "https://github.com/lupaxa-git-toolbox/git-reset-history/archive/refs/tags/v0.1.5.tar.gz"
  sha256 "3e90d2fdb40f0a0afa23725fcd3ba089692ecdccdfed5e8c79157c005d2641d5"
  license "MIT"

  def install
    bin.install "src/git-reset-history"
  end

  test do
    assert_match "Rewrite a Git repository down to a single initial commit", shell_output("#{bin}/git-reset-history --help")
  end
end
