class Codexx < Formula
  desc "Create executable files and open them in VS Code"
  homepage "https://github.com/zdennis/bin"
  version "1.0.0"
  url "https://raw.githubusercontent.com/zdennis/bin/code+x-v#{version}/bin/code+x"
  sha256 "c169c643f4f9c915b6e2696f7bc4c55e5f6bc6373c812dcda5ab6bfddf592cda"
  license "MIT"

  depends_on "zdennis/bin/touchp"

  def install
    bin.install "code+x"
  end

  test do
    assert_match "code+x", shell_output("#{bin}/code+x --version")
  end
end
