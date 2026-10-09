class SafeRm < Formula
  desc "Recoverable replacement for interactive rm and rmdir"
  homepage "https://github.com/lupaxa-workstation-toolbox/safe-rm"
  url "https://github.com/lupaxa-workstation-toolbox/safe-rm/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "06d61c6a8e907757dc12695346e2fea2dcc3b6080ebed64afd26ce7f641e92cb"
  license "MIT"

  def install
    bin.install "src/safe-rm"
  end

  test do
    assert_match "safe-rm [options] path...", shell_output("#{bin}/safe-rm --help")
  end
end
