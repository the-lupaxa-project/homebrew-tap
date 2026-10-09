class GitChangeBranchName < Formula
  desc "Bash CLI to rename a local Git branch and the same branch on the remote, with dry-run, summary, and local-only modes"
  homepage "https://github.com/lupaxa-git-toolbox/git-change-branch-name"
  url "https://github.com/lupaxa-git-toolbox/git-change-branch-name/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "92aa29043e47cab1d86ade260352f4db1702eb4c2b4d5ba63cb411e3bdf8f6b0"
  license "MIT"

  def install
    bin.install "src/git-change-branch-name"
  end

  test do
    assert_match "Rename a local branch, then publish the new name", shell_output("#{bin}/git-change-branch-name --help")
  end
end
