class WindowTool < Formula
  desc "Fast macOS CLI for listing, moving, and resizing application windows"
  homepage "https://github.com/zdennis/window-tool"
  url "https://github.com/zdennis/window-tool/archive/refs/tags/v0.16.0.tar.gz"
  sha256 "e9fe420649b8717a2b924e9041563f13ec3bf86b80471240331f7ea00b60cca5"
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
