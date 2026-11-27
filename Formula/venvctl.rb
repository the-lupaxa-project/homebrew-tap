class Venvctl < Formula
  desc "Create, inspect, and remove Python virtual environments from one Bash script"
  homepage "https://github.com/lupaxa-workstation-toolbox/venvctl"
  url "https://github.com/lupaxa-workstation-toolbox/venvctl/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "aa41d50cddc50117637347d764f13045db8367ac03892bc02846d6d7c7fbe9be"
  license "MIT"

  def install
    bin.install "src/venvctl"
  end

  test do
    assert_match "venvctl <command> [options]", shell_output("#{bin}/venvctl --help")
  end
end
