class QueueCommands < Formula
  desc "Run commands from a file sequentially, pausing on errors"
  homepage "https://github.com/zdennis/bin"
  version "1.0.0"
  url "https://raw.githubusercontent.com/zdennis/bin/queue-commands-v1.0.0/bin/queue-commands"
  sha256 "05b59d96db7f773167752df04db90095ec406346b428d9498d8ffd0ed9b201f7"
  license "MIT"

  depends_on "ruby"

  def install
    bin.install "queue-commands"
  end

  test do
    assert_match "queue-commands 1.0.0", shell_output("#{bin}/queue-commands --version", 0)
  end
end
