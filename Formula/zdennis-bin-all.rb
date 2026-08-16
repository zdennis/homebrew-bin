class ZdennisBinAll < Formula
  desc "Install all zdennis/bin tools"
  homepage "https://github.com/zdennis/bin"
  url "https://raw.githubusercontent.com/zdennis/bin/zdennis-bin-all-v1.29.1/bin/zdennis-bin-all"
  sha256 "8eaa1d91a1912a42855ff5e5d1d9356c3119b6d866693ff9b81e7dfdfbc762fe"
  license "MIT"

  depends_on "zdennis/bin/alias-directory"
  depends_on "zdennis/bin/ascii-banner"
  depends_on "zdennis/bin/code+x"
  depends_on "zdennis/bin/codep"
  depends_on "zdennis/bin/expand-keyword"
  depends_on "zdennis/bin/html-viewer"
  depends_on "zdennis/bin/queue-commands"
  depends_on "zdennis/bin/retry-command"
  depends_on "zdennis/bin/run-through"
  depends_on "zdennis/bin/set-random-background-color"
  depends_on "zdennis/bin/touchp"
  depends_on "zdennis/bin/window-tool"
  depends_on "zdennis/bin/work-coordinator"
  depends_on "zdennis/bin/workspace"

  def install
    bin.install "zdennis-bin-all"
  end

  test do
    assert_match "zdennis/bin tools", shell_output("#{bin}/zdennis-bin-all")
  end
end
