class WindowTool < Formula
  desc "Fast macOS CLI for listing, moving, and resizing application windows"
  homepage "https://github.com/zdennis/window-tool"
  url "https://github.com/zdennis/window-tool/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "ca07ae125246d10d4cf58ed5b4438ca66af08c12de6716fde51d657433f60413"
  license "MIT"

  depends_on :macos

  def install
    system "swiftc", "-O",
           "-o", "window-tool",
           "src/window-tool.swift",
           "-framework", "Cocoa"
    bin.install "window-tool"
  end

  test do
    assert_match "window-tool", shell_output("#{bin}/window-tool --version")
  end
end
