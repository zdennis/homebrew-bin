class HtmlViewer < Formula
  desc "Always-on-top macOS window for viewing HTML, Markdown files and URLs from the CLI"
  homepage "https://github.com/zdennis/html-viewer"
  url "https://github.com/zdennis/html-viewer/archive/refs/tags/v0.10.0.tar.gz"
  sha256 "32d10c77d13ebbda1934d34476342d09958f4ca2490e9eda6d76e9d4a10fa925"
  license "MIT"

  depends_on :macos
  depends_on "node"

  on_arm do
    resource "electron" do
      url "https://github.com/electron/electron/releases/download/v28.3.3/electron-v28.3.3-darwin-arm64.zip"
      sha256 "c310ab098d8849c4aa05f05b1c8521031241a046e023a911f964fd1db31c64c9"
    end
  end

  on_intel do
    resource "electron" do
      url "https://github.com/electron/electron/releases/download/v28.3.3/electron-v28.3.3-darwin-x64.zip"
      sha256 "6bc63916b7fe52de7559e7631fef5c93315a18ee90a0d3d08168c91414b09ecf"
    end
  end

  def install
    # Skip Electron's postinstall download — we supply the binary ourselves
    ENV["ELECTRON_SKIP_BINARY_DOWNLOAD"] = "1"
    system "npm", "install"

    # Place the pre-downloaded Electron binary where the npm package expects it
    electron_dist = buildpath/"node_modules/electron/dist"
    electron_dist.mkpath
    resource("electron").stage { electron_dist.install Dir["*"] }
    # Write the path.txt file that electron/index.js requires to locate the binary
    (buildpath/"node_modules/electron/path.txt").write "Electron.app/Contents/MacOS/Electron"

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
