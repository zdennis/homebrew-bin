class All < Formula
  desc "Install all zdennis/bin tools"
  homepage "https://github.com/zdennis/bin"
  version "1.0.0"
  license "MIT"

  depends_on "zdennis/bin/alias-directory"
  depends_on "zdennis/bin/ascii-banner"
  depends_on "zdennis/bin/codep"
  depends_on "zdennis/bin/queue-commands"
  depends_on "zdennis/bin/run-through"
  depends_on "zdennis/bin/set-random-background-color"
  depends_on "zdennis/bin/touchp"

  def install
    (prefix/"README").write "Meta-formula for all zdennis/bin tools"
  end

  test do
    assert_predicate prefix/"README", :exist?
  end
end
