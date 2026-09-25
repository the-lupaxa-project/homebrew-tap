class BrewManager < Formula
  desc "Interactive Homebrew maintenance menu for workstation brew state"
  homepage "https://github.com/lupaxa-workstation-toolbox/brew-manager"
  url "https://github.com/lupaxa-workstation-toolbox/brew-manager/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "fa5ac6364c2963bec705bd11ef8ee12ebd542d84babab3713b1e8c12f1493204"
  license "MIT"

  def install
    bin.install "src/brew-manager"
  end

  test do
    assert_match "Usage: brew-manager", shell_output("#{bin}/brew-manager --help")
  end
end
