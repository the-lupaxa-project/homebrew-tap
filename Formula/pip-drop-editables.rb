class PipDropEditables < Formula
  desc "Uninstall editable pip installs so a published release can replace them"
  homepage "https://github.com/lupaxa-workstation-toolbox/pip-drop-editables"
  url "https://github.com/lupaxa-workstation-toolbox/pip-drop-editables/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "a1953bbb806486a2e0c1310ebcd5a5786ef2e41340ea14fff6aba279d8745168"
  license "MIT"

  def install
    bin.install "src/pip-drop-editables"
  end

  test do
    assert_match "Usage: pip-drop-editables", shell_output("#{bin}/pip-drop-editables --help")
  end
end
