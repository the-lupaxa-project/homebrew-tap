class SafeRm < Formula
  desc "Recoverable replacement for interactive rm and rmdir"
  homepage "https://github.com/lupaxa-workstation-toolbox/safe-rm"
  url "https://github.com/lupaxa-workstation-toolbox/safe-rm/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "6e42e2069c8fbd17cf5b44c563ee2f31122b78a221f2bfe1794feaaf305004fe"
  license "MIT"

  def install
    bin.install "src/safe-rm"
  end

  test do
    assert_match "safe-rm [options] path...", shell_output("#{bin}/safe-rm --help")
  end
end
