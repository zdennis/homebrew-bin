class RunThrough < Formula
  desc "Run files through multiple shell commands"
  homepage "https://github.com/zdennis/bin"
  version "1.1.0"
  url "https://raw.githubusercontent.com/zdennis/bin/run-through-v#{version}/bin/run-through"
  sha256 "f33981824b3ecd41ace46cae75de7747cfb66f356764cf152f92a0376f76973e"
  license "MIT"

  depends_on "ruby"

  def install
    bin.install "run-through"
  end

  test do
    assert_match "run-through #{version}", shell_output("#{bin}/run-through --version")
  end
end
