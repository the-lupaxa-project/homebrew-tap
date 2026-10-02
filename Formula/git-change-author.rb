class GitChangeAuthor < Formula
  desc "Bash CLI to rewrite Git commit author and committer identity for one email address, with dry-run, summary, and local-only modes"
  homepage "https://github.com/lupaxa-git-toolbox/git-change-author"
  url "https://github.com/lupaxa-git-toolbox/git-change-author/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "1a43f8fe23fb795ccf29bf73c4906e17ee2b7748eeec2d5b82d2fc02b066dc1d"
  license "MIT"

  def install
    bin.install "src/git-change-author"
  end

  test do
    assert_match "Rewrite author and committer identity for one email address", shell_output("#{bin}/git-change-author --help")
  end
end
