class ExpandKeyword < Formula
  desc "Manage $KEYWORD text expansions for Claude Code hook integration"
  homepage "https://github.com/zdennis/expand-keywords"
  url "https://github.com/zdennis/expand-keywords/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "7ebd5dfdd7520c3f898146ce0e3599f03149214ac5b9c26fa4b61d22caa3841d"
  license "MIT"
  version "0.1.0"

  depends_on "ruby"

  def install
    ruby = Formula["ruby"].opt_bin/"ruby"
    (bin/"expand-keyword").write <<~SH
      #!/bin/bash
      export RUBYLIB="#{lib}/expand-keyword:$RUBYLIB"
      exec "#{ruby}" "#{libexec}/expand-keyword" "$@"
    SH
    libexec.install "bin/expand-keyword"
    lib.mkpath
    (lib/"expand-keyword").install Dir["lib/expand_keyword"]
  end

  test do
    assert_match "0.1.0", shell_output("#{bin}/expand-keyword --version")
  end
end
