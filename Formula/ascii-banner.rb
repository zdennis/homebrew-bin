class AsciiBanner < Formula
  desc "Create ASCII art banners with color, sizing, and alignment options"
  homepage "https://github.com/zdennis/bin"
  url "https://raw.githubusercontent.com/zdennis/bin/ascii-banner-v1.3.0/bin/ascii-banner"
  sha256 "6978fbaf807996901d96b776911b34c3e50f8251b7ec983d594d53bf286d7322"
  license "MIT"

  depends_on "ruby"

  def install
    bin.install "ascii-banner"
  end

  test do
    assert_match "ascii-banner", shell_output("#{bin}/ascii-banner --version")
  end
end
