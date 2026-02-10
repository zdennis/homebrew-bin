class RetryCommand < Formula
  desc "Retry commands with configurable delay, limits, and supervisor mode"
  homepage "https://github.com/zdennis/bin"
  url "https://raw.githubusercontent.com/zdennis/bin/retry-command-v1.0.1/bin/retry-command"
  sha256 "a5d2d6ee04287eeb30975003bd8374c6c60b3ad3d0292b26b686549571c16d34"
  license "MIT"

  def install
    bin.install "retry-command"
  end

  test do
    assert_match "retry-command 1.0.1", shell_output("#{bin}/retry-command --version")
  end
end
