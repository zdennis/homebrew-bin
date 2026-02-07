class Codep < Formula
  desc "Touch files with parent directories and open them in VS Code"
  homepage "https://github.com/zdennis/bin"
  version "1.0.0"
  url "https://raw.githubusercontent.com/zdennis/bin/codep-v#{version}/bin/codep"
  sha256 "a173e25c3381d04c1a86df46dca7b6c7d1fcae2a81bc1ff1043339911004e05a"
  license "MIT"

  depends_on "zdennis/bin/touchp"

  def install
    bin.install "codep"
  end

  test do
    assert_match "codep #{version}", shell_output("#{bin}/codep --version")
  end
end
