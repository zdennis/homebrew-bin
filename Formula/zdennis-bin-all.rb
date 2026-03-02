class ZdennisBinAll < Formula
  desc "Install all zdennis/bin tools"
  homepage "https://github.com/zdennis/bin"
  url "https://raw.githubusercontent.com/zdennis/bin/zdennis-bin-all-v1.2.0/bin/zdennis-bin-all"
  sha256 "e92dc3de189d7d258244970741cda83c4a1cd43c2d932a2f4cc1dd13d720ba74"
  license "MIT"

  depends_on "zdennis/bin/alias-directory"
  depends_on "zdennis/bin/ascii-banner"
  depends_on "zdennis/bin/code+x"
  depends_on "zdennis/bin/codep"
  depends_on "zdennis/bin/queue-commands"
  depends_on "zdennis/bin/retry-command"
  depends_on "zdennis/bin/run-through"
  depends_on "zdennis/bin/set-random-background-color"
  depends_on "zdennis/bin/touchp"

  def install
    bin.install "zdennis-bin-all"
  end

  test do
    assert_match "zdennis/bin tools", shell_output("#{bin}/zdennis-bin-all")
  end
end
