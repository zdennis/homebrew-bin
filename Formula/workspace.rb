class Workspace < Formula
  desc "Manage tmuxinator-based development workspaces in iTerm2"
  homepage "https://github.com/zdennis/workspace"
  url "https://github.com/zdennis/workspace/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "ddcffb15916c9fd957816c06d7da2fc9d291428327cf5bf1fd134c7add12ee2a"
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
