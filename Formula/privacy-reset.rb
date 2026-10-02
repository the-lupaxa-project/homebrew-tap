class PrivacyReset < Formula
  desc "Interactive menu to reset macOS privacy grants for one app or every app"
  homepage "https://github.com/lupaxa-workstation-toolbox/privacy-reset"
  url "https://github.com/lupaxa-workstation-toolbox/privacy-reset/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "c724328dcbd0b2f3b843970eec9673b1782f5b4f68a1eaa39a65711763e89535"
  license "MIT"

  def install
    bin.install "src/privacy-reset"
  end

  test do
    assert_match "Usage: privacy-reset", shell_output("#{bin}/privacy-reset --help")
  end
end
