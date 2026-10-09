class BrewManager < Formula
  desc "Helper tooling for managing Homebrew packages and workstation brew state"
  homepage "https://github.com/lupaxa-workstation-toolbox/brew-manager"
  url "https://github.com/lupaxa-workstation-toolbox/brew-manager/archive/refs/tags/v0.1.7.tar.gz"
  sha256 "6fdbc8bc61d964ddd288d36d75bdbbba4d4d52aca50b3e707a03b3426a77c91a"
  license "MIT"

  def install
    bin.install "src/brew-manager"
  end

  test do
    assert_match "Usage: brew-manager", shell_output("#{bin}/brew-manager --help")
  end
end
