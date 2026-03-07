class WindowTool < Formula
  desc "Fast macOS CLI for listing, moving, and resizing application windows"
  homepage "https://github.com/zdennis/window-tool"
  url "https://github.com/zdennis/window-tool/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "260e5d3321837d96c40ad2775f4442e233b6d9e3b7cd0268f7ad43cac99a2656"
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
    assert_match "window-tool", shell_output("#{bin}/window-tool --help")
  end
end
