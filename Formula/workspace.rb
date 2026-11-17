class Workspace < Formula
  desc "Manage tmuxinator-based development workspaces in iTerm2"
  homepage "https://github.com/zdennis/workspace"
  url "https://github.com/zdennis/workspace/archive/refs/tags/v0.146.0.tar.gz"
  sha256 "9aae954244428ae2203e4f3d693f09c60dcc433a84b0181d14298e4fe8ae1fb7"
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
