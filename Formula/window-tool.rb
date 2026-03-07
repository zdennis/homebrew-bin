class WindowTool < Formula
  desc "Fast macOS CLI for listing, moving, and resizing application windows"
  homepage "https://github.com/zdennis/window-tool"
  url "https://github.com/zdennis/window-tool/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "d11a2292987f1cfd9828163f240ff099e0692b7fcb6c43ec242e4baf10caa65e"
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
