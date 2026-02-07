class AliasDirectory < Formula
  desc "Manage directory aliases for quick cd navigation"
  homepage "https://github.com/zdennis/bin"
  version "1.0.0"
  url "https://raw.githubusercontent.com/zdennis/bin/alias-directory-v#{version}/bin/alias-directory"
  sha256 "ea8db8725098207b48ce23064137927ab62022a0813570ec40cc41f021ce92fb"
  license "MIT"

  depends_on "ruby"

  def install
    bin.install "alias-directory"
  end

  test do
    assert_match "alias-directory #{version}", shell_output("#{bin}/alias-directory --version")
  end
end
