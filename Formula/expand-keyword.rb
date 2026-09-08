class ExpandKeyword < Formula
  desc "Manage $KEYWORD text expansions for Claude Code hook integration"
  homepage "https://github.com/zdennis/expand-keywords"
  url "https://github.com/zdennis/expand-keywords/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "ad0cce3cdcb87a4537014c459d672d07c290cefa323bb9e960f9a2214ff286b5"
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
