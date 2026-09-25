class GitCryptManager < Formula
  desc "A secure, guided automation tool for managing encrypted repositories using git-crypt"
  homepage "https://github.com/lupaxa-security-toolbox/git-crypt-manager"
  url "https://github.com/lupaxa-security-toolbox/git-crypt-manager/archive/refs/tags/v1.0.4.tar.gz"
  sha256 "36a9d09b11bce2784749e31df03e65163223b01b62a37a57b59bcdc7e09d54f6"
  license "MIT"

  depends_on "git"
  depends_on "git-crypt"
  depends_on "gnupg"

  def install
    bin.install "src/gcm"
  end

  test do
    assert_match "gcm <command> [args]", shell_output("#{bin}/gcm --help")
  end
end
