class ExpandKeyword < Formula
  desc "Manage $KEYWORD text expansions for Claude Code hook integration"
  homepage "https://github.com/zdennis/expand-keywords"
  url "https://github.com/zdennis/expand-keywords/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "20636c220c87e231c404caaf4009d69587bfb1a231b27f063914765d32082d3c"
  license "MIT"

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
    assert_match version.to_s, shell_output("#{bin}/expand-keyword --version")
  end
end
