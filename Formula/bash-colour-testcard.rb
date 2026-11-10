class BashColourTestcard < Formula
  desc "Bash terminal colour testcard with simple, complete, count, and interactive test modes"
  homepage "https://github.com/lupaxa-developers-toolbox/bash-colour-testcard"
  url "https://github.com/lupaxa-developers-toolbox/bash-colour-testcard/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "e043cdba1074227c5e586901316444474a3055067ba263d1f4b2327d788fbe8a"
  license "MIT"

  def install
    bin.install "src/bash-colour-testcard.sh" => "bash-colour-testcard"
  end

  test do
    ENV["TERM"] = "xterm-256color"
    assert_match "[ -h ] [ -V ] [ -cnst ]", shell_output("#{bin}/bash-colour-testcard -h")
  end
end
