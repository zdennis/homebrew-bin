class AsciiBanner < Formula
  desc "Create ASCII art banners with color, sizing, and alignment options"
  homepage "https://github.com/zdennis/bin"
  url "https://raw.githubusercontent.com/zdennis/bin/master/bin/ascii-banner"
  version "1.0.0"
  sha256 "2ae8f88fd91b5932ec405b56a5cbe069682fcb593459071bbd47fbec93c31810"
  license "MIT"

  depends_on "ruby"

  def install
    bin.install "ascii-banner"
  end

  test do
    assert_match "HI", shell_output("#{bin}/ascii-banner HI")
  end
end
