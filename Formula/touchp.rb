class Touchp < Formula
  desc "Touch a file and create parent directories in its path"
  homepage "https://github.com/zdennis/bin"
  version "1.0.0"
  url "https://raw.githubusercontent.com/zdennis/bin/touchp-v#{version}/bin/touchp"
  sha256 "756920c4e29d38c78c00fd16502a13d57fbc91647a615fa107f00029cadaae39"
  license "MIT"

  depends_on "ruby"

  def install
    bin.install "touchp"
  end

  test do
    assert_match "touchp #{version}", shell_output("#{bin}/touchp --version")
  end
end
