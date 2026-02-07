class RunThrough < Formula
  desc "Run files through multiple shell commands"
  homepage "https://github.com/zdennis/bin"
  version "1.0.0"
  url "https://raw.githubusercontent.com/zdennis/bin/run-through-v#{version}/bin/run-through"
  sha256 "125d454f274cfa23c767f8b2c4e9f60ee2f0ef1ad8907104dfcebb87571b7221"
  license "MIT"

  depends_on "ruby"

  def install
    bin.install "run-through"
  end

  test do
    assert_match "run-through #{version}", shell_output("#{bin}/run-through --version")
  end
end
