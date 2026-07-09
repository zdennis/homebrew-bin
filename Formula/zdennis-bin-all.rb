class ZdennisBinAll < Formula
  desc "Install all zdennis/bin tools"
  homepage "https://github.com/zdennis/bin"
  url "https://raw.githubusercontent.com/zdennis/bin/zdennis-bin-all-v1.26.4/bin/zdennis-bin-all"
  sha256 "5474ed571c9d0d61d17c598f000bb108902067a93339217612578c846c9e37a8"
  license "MIT"

  depends_on "zdennis/bin/alias-directory"
  depends_on "zdennis/bin/ascii-banner"
  depends_on "zdennis/bin/code+x"
  depends_on "zdennis/bin/codep"
  depends_on "zdennis/bin/html-viewer"
  depends_on "zdennis/bin/queue-commands"
  depends_on "zdennis/bin/retry-command"
  depends_on "zdennis/bin/run-through"
  depends_on "zdennis/bin/set-random-background-color"
  depends_on "zdennis/bin/touchp"
  depends_on "zdennis/bin/window-tool"
  depends_on "zdennis/bin/workspace"

  def install
    bin.install "zdennis-bin-all"
  end

  test do
    assert_match "zdennis/bin tools", shell_output("#{bin}/zdennis-bin-all")
  end
end
