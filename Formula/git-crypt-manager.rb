class GitCryptManager < Formula
  desc "A secure, guided automation tool for managing encrypted repositories using git-crypt"
  homepage "https://github.com/lupaxa-security-toolbox/git-crypt-manager"
  url "https://github.com/lupaxa-security-toolbox/git-crypt-manager/archive/refs/tags/v1.0.8.tar.gz"
  sha256 "bb3fcbd02a41d27017ec79a785109ca8a98450e4e6c308d840ce55d4df7b0267"
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
