class GitChangeBranchName < Formula
  desc "Bash CLI to rename a local Git branch and the same branch on the remote, with dry-run, summary, and local-only modes"
  homepage "https://github.com/lupaxa-git-toolbox/git-change-branch-name"
  url "https://github.com/lupaxa-git-toolbox/git-change-branch-name/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "ec7b275e128b6751be9c2b1d64ea9de39377214ff153287545843a0632f12055"
  license "MIT"

  def install
    bin.install "src/git-change-branch-name"
  end

  test do
    assert_match "Rename a local branch, then publish the new name", shell_output("#{bin}/git-change-branch-name --help")
  end
end
