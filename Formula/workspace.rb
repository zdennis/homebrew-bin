class Workspace < Formula
  desc "Manage tmuxinator-based development workspaces in iTerm2"
  homepage "https://github.com/zdennis/workspace"
  url "https://github.com/zdennis/workspace/archive/refs/tags/v0.14.0.tar.gz"
  sha256 "fb9fe03442bb6a3b7553da5f9d25eccf2ddfc3160982c11b04b04f00749c3196"
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
