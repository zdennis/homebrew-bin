class Workspace < Formula
  desc "Manage tmuxinator-based development workspaces in iTerm2"
  homepage "https://github.com/zdennis/workspace"
  url "https://github.com/zdennis/workspace/archive/refs/tags/v0.35.0.tar.gz"
  sha256 "5cd23fa78867592b3d055a9248c5c4f197ac7a975ef657aada2afdb004057004"
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
