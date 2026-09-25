class BrewManager < Formula
  desc "Helper tooling for managing Homebrew packages and workstation brew state"
  homepage "https://github.com/lupaxa-workstation-toolbox/brew-manager"
  url "https://github.com/lupaxa-workstation-toolbox/brew-manager/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "a5576fd41852a8acc1859927ca1a844e9b12233e2d38a9e6c2f8559ca44d827d"
  license "MIT"

  def install
    bin.install "src/brew-manager"
  end

  test do
    assert_match "Usage: brew-manager", shell_output("#{bin}/brew-manager --help")
  end
end
