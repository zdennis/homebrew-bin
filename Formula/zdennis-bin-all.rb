class ZdennisBinAll < Formula
  desc "Install all zdennis/bin tools"
  homepage "https://github.com/zdennis/bin"
  version "1.1.2"
  url "https://raw.githubusercontent.com/zdennis/bin/zdennis-bin-all-v#{version}/bin/zdennis-bin-all"
  sha256 "20a319b957b51b89310d46391b7c68f8ae9f8db5ae863ef6920a536d99ccc3ff"
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
