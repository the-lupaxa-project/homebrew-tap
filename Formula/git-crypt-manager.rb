class GitCryptManager < Formula
  desc "A secure, guided automation tool for managing encrypted repositories using git-crypt"
  homepage "https://github.com/lupaxa-security-toolbox/git-crypt-manager"
  url "https://github.com/lupaxa-security-toolbox/git-crypt-manager/archive/refs/tags/v1.0.7.tar.gz"
  sha256 "4f42b4930a484e01c3cf8d87f587d88b0533a7a083b10f1f457ebe31e8f340b9"
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
