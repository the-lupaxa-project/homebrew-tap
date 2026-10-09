class PrivacyReset < Formula
  desc "Interactive menu to reset macOS privacy grants for one app or every app"
  homepage "https://github.com/lupaxa-workstation-toolbox/privacy-reset"
  url "https://github.com/lupaxa-workstation-toolbox/privacy-reset/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "bc9f9e73ca6f7d91d45742dbc0d6f8b94f3e46d8d20eb5567bd81692b7437be7"
  license "MIT"

  def install
    bin.install "src/privacy-reset"
  end

  test do
    assert_match "Usage: privacy-reset", shell_output("#{bin}/privacy-reset --help")
  end
end
