class GitDeleteTags < Formula
  desc "Bash CLI to delete local and remote Git tags, with protection, dry-run, and summary modes"
  homepage "https://github.com/lupaxa-git-toolbox/git-delete-tags"
  url "https://github.com/lupaxa-git-toolbox/git-delete-tags/archive/refs/tags/v0.1.5.tar.gz"
  sha256 "b331d88de72196d92df1536bf8174654957c5d2f56e341483929033868c7bef3"
  license "MIT"

  def install
    bin.install "src/git-delete-tags"
  end

  test do
    assert_match "[tag ...] | all [options]", shell_output("#{bin}/git-delete-tags --help")
  end
end
