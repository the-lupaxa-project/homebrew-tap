class PrivacyReset < Formula
  desc "Interactive menu to reset macOS privacy grants for one app or every app"
  homepage "https://github.com/lupaxa-workstation-toolbox/privacy-reset"
  url "https://github.com/lupaxa-workstation-toolbox/privacy-reset/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "d78c2787c32c14c72800089eb32df929c449c69086b54f7a0997f0e28a5bc844"
  license "MIT"

  def install
    bin.install "src/privacy-reset"
  end

  test do
    assert_match "Usage: privacy-reset", shell_output("#{bin}/privacy-reset --help")
  end
end
