class Workspace < Formula
  desc "Manage tmuxinator-based development workspaces in iTerm2"
  homepage "https://github.com/zdennis/workspace"
  url "https://github.com/zdennis/workspace/archive/refs/tags/v0.21.0.tar.gz"
  sha256 "87ba5f731e3fcd2acee9a97d0aa296ea83039b8519c7ec881e5f1709f7343b4d"
  license "MIT"

  depends_on :macos
  depends_on "ruby"
  depends_on "zdennis/bin/window-tool"

  def install
    libexec.install "lib", "bin"

    (bin/"workspace").write <<~BASH
      #!/bin/bash
      exec ruby "#{libexec}/bin/workspace" "$@"
    BASH
  end

  test do
    assert_match "workspace", shell_output("#{bin}/workspace --version")
  end
end
