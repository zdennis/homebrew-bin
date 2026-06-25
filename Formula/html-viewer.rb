class HtmlViewer < Formula
  desc "Always-on-top macOS window for viewing HTML files and URLs from the CLI"
  homepage "https://github.com/zdennis/html-viewer"
  url "https://github.com/zdennis/html-viewer/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "2a269a50259cdb9a3b1ca31f400aa9c2bcbd0681ac8b0d6ae5ba6871beb9a250"
  license "MIT"

  depends_on :macos
  depends_on "node"

  def install
    system "npm", "install", "--production", "--ignore-scripts"
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
