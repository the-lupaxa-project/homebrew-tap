class GitChangeAuthor < Formula
  desc "Bash CLI to rewrite Git commit author and committer identity for one email address, with dry-run, summary, and local-only modes"
  homepage "https://github.com/lupaxa-git-toolbox/git-change-author"
  url "https://github.com/lupaxa-git-toolbox/git-change-author/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "1768396b9b0ff7ec2725bd0d7b23be6bf3e2bb32e486e217c716c8e1f635714a"
  license "MIT"

  def install
    bin.install "src/git-change-author"
  end

  test do
    assert_match "Rewrite author and committer identity for one email address", shell_output("#{bin}/git-change-author --help")
  end
end
