class WindowTool < Formula
  desc "Fast macOS CLI for listing, moving, and resizing application windows"
  homepage "https://github.com/zdennis/window-tool"
  url "https://github.com/zdennis/window-tool/archive/refs/tags/v0.10.0.tar.gz"
  sha256 "a5c6e91f57b4a6d9dd595ea4888cb0212d1015d44ba199a0b5f98883f80d53fb"
  license "MIT"

  depends_on :macos

  def install
    system "swiftc", "-O",
           "-o", "window-tool",
           "src/window-tool.swift",
           "-framework", "Cocoa",
           "-framework", "AVFoundation",
           "-framework", "ScreenCaptureKit"
    bin.install "window-tool"
  end

  test do
    assert_match "window-tool", shell_output("#{bin}/window-tool --version")
  end
end
