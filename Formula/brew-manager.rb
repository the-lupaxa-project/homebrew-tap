class BrewManager < Formula
  desc "Helper tooling for managing Homebrew packages and workstation brew state"
  homepage "https://github.com/lupaxa-workstation-toolbox/brew-manager"
  url "https://github.com/lupaxa-workstation-toolbox/brew-manager/archive/refs/tags/v0.1.6.tar.gz"
  sha256 "32bb0ddeff783cce73de6cbbded886a48bdcf6c1b9f7938752735cfb75934828"
  license "MIT"

  def install
    bin.install "src/brew-manager"
  end

  test do
    assert_match "Usage: brew-manager", shell_output("#{bin}/brew-manager --help")
  end
end
