class WindowTool < Formula
  desc "Fast macOS CLI for listing, moving, and resizing application windows"
  homepage "https://github.com/zdennis/window-tool"
  url "https://github.com/zdennis/window-tool/archive/refs/tags/v0.14.1.tar.gz"
  sha256 "a1b4fd330e092f929c8a49c1f2e35f054f2d53714eafe35c6c542db924da61f0"
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
