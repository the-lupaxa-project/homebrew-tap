class GitDeleteTags < Formula
  desc "Bash CLI to delete local and remote Git tags, with protection, dry-run, and summary modes"
  homepage "https://github.com/lupaxa-git-toolbox/git-delete-tags"
  url "https://github.com/lupaxa-git-toolbox/git-delete-tags/archive/refs/tags/v0.1.6.tar.gz"
  sha256 "0af1c462bb1647a9327a0527a8c23a0b62f8138e9694aa495692843640f0df96"
  license "MIT"

  def install
    bin.install "src/git-delete-tags"
  end

  test do
    assert_match "[tag ...] | all [options]", shell_output("#{bin}/git-delete-tags --help")
  end
end
