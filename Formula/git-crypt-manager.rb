class GitCryptManager < Formula
  desc "A secure, guided automation tool for managing encrypted repositories using git-crypt"
  homepage "https://github.com/lupaxa-security-toolbox/git-crypt-manager"
  url "https://github.com/lupaxa-security-toolbox/git-crypt-manager/archive/refs/tags/v1.0.3.tar.gz"
  sha256 "6cabd00d9a920c64e129c9c2dbed758fc2b19aa8272ae6ad87f08fce97db4e58"
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
