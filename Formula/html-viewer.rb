class HtmlViewer < Formula
  desc "Always-on-top macOS window for viewing HTML files and URLs from the CLI"
  homepage "https://github.com/zdennis/html-viewer"
  url "https://github.com/zdennis/html-viewer/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "fca803099c73273f9882c569ae0fb779a27ac82ce5f333ba977842b6b3d3dc88"
  license "MIT"

  depends_on :macos
  depends_on "node"

  def install
    system "npm", "install"
    libexec.install Dir["*"]

    (bin/"html-viewer").write <<~BASH
      #!/bin/bash
      exec node "#{libexec}/bin/html-viewer" "$@"
    BASH
  end

  test do
    assert_match "Usage: html-viewer", shell_output("#{bin}/html-viewer --help")
  end
end
