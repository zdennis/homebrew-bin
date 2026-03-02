class AsciiBanner < Formula
  desc "Create ASCII art banners with color, sizing, and alignment options"
  homepage "https://github.com/zdennis/bin"
  url "https://raw.githubusercontent.com/zdennis/bin/ascii-banner-v1.1.0/bin/ascii-banner"
  sha256 "e1c3a7af6329ad930263bf55b214b6b220fab335ac42c6fc644854d9eeef1d50"
  license "MIT"

  depends_on "ruby"

  def install
    bin.install "ascii-banner"
  end

  test do
    assert_match "ascii-banner", shell_output("#{bin}/ascii-banner --version")
  end
end
