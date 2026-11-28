class Venvctl < Formula
  desc "Create, inspect, and remove Python virtual environments from one Bash script"
  homepage "https://github.com/lupaxa-workstation-toolbox/venvctl"
  url "https://github.com/lupaxa-workstation-toolbox/venvctl/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "bef2f5f2feebde2f47391523602d2a2d58af4112fa0b26f5d07e4d631921e813"
  license "MIT"

  def install
    bin.install "src/venvctl"
  end

  test do
    assert_match "venvctl <command> [options]", shell_output("#{bin}/venvctl --help")
  end
end
