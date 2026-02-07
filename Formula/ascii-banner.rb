class AsciiBanner < Formula
  desc "Create ASCII art banners with color, sizing, and alignment options"
  homepage "https://github.com/zdennis/bin"
  url "https://raw.githubusercontent.com/zdennis/bin/master/bin/ascii-banner"
  version "1.0.0"
  sha256 "d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed"
  license "MIT"

  depends_on "ruby"

  def install
    bin.install "ascii-banner"
  end

  test do
    assert_match "HI", shell_output("#{bin}/ascii-banner HI")
  end
end
