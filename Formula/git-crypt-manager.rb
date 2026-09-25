class GitCryptManager < Formula
  desc "A secure, guided automation tool for managing encrypted repositories using git-crypt"
  homepage "https://github.com/lupaxa-security-toolbox/git-crypt-manager"
  url "https://github.com/lupaxa-security-toolbox/git-crypt-manager/archive/refs/tags/v1.0.5.tar.gz"
  sha256 "dfee722a00e42863a64113a6c0f3d2ef8de9c80a865607c65ecf524e454527a1"
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
