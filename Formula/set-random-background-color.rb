class SetRandomBackgroundColor < Formula
  desc "Set iTerm2 background to a random dark color"
  homepage "https://github.com/zdennis/bin"
  url "https://raw.githubusercontent.com/zdennis/bin/set-random-background-color-v1.0.0/bin/set-random-background-color"
  sha256 "6ca6967567a71665b54f506ac72a143eea3da2412be679c35507562a86fab4bc"
  license "MIT"

  def install
    bin.install "set-random-background-color"
  end

  test do
    assert_match "set-random-background-color 1.0.0", shell_output("#{bin}/set-random-background-color --version")
  end
end
