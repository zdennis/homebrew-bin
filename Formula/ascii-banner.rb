class AsciiBanner < Formula
  desc "Create ASCII art banners with color, sizing, and alignment options"
  homepage "https://github.com/zdennis/bin"
  url "https://raw.githubusercontent.com/zdennis/bin/ascii-banner-v1.0.0/bin/ascii-banner"
  sha256 "6b29d4b246c22e473918907a578ec34427b07b89d13799f3b7550f4e98f4f84c"
  license "MIT"

  depends_on "ruby"

  def install
    bin.install "ascii-banner"
  end

  test do
    assert_match "ascii-banner", shell_output("#{bin}/ascii-banner --version")
  end
end
