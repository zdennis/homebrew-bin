class AsciiBanner < Formula
  desc "Create ASCII art banners with color, sizing, and alignment options"
  homepage "https://github.com/zdennis/bin"
  url "https://raw.githubusercontent.com/zdennis/bin/ascii-banner-v1.2.0/bin/ascii-banner"
  sha256 "cdb96a3714ee93623f0209f2ed82d4005dd2ad266dbb7db0c277396caf1e2f47"
  license "MIT"

  depends_on "ruby"

  def install
    bin.install "ascii-banner"
  end

  test do
    assert_match "ascii-banner", shell_output("#{bin}/ascii-banner --version")
  end
end
