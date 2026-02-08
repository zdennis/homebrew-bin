class RetryCommand < Formula
  desc "Retry commands with configurable delay, limits, and supervisor mode"
  homepage "https://github.com/zdennis/bin"
  version "1.0.0"
  url "https://raw.githubusercontent.com/zdennis/bin/retry-command-v1.0.0/bin/retry-command"
  sha256 "1a9356aa07b181a63b15ec1a5d343482d89ab95ae5aa8efe5daf13daa41144e3"
  license "MIT"

  def install
    bin.install "retry-command"
  end

  test do
    assert_match "retry-command 1.0.0", shell_output("#{bin}/retry-command --version")
  end
end
