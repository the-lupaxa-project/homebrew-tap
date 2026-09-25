class GitDeleteTags < Formula
  desc "Bash CLI to delete local and remote Git tags, with protection, dry-run, and summary modes"
  homepage "https://github.com/lupaxa-git-toolbox/git-delete-tags"
  url "https://github.com/lupaxa-git-toolbox/git-delete-tags/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "6ebd323e961467d4f33bd8a2a3ed9ab771b8d43c654ea6252a23a656a5cf0bb8"
  license "MIT"

  def install
    bin.install "src/git-delete-tags"
  end

  test do
    assert_match "[tag ...] | all [options]", shell_output("#{bin}/git-delete-tags --help")
  end
end
