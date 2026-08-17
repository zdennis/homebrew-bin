class WorkCoordinator < Formula
  desc "Route messages to AI agents running in tmux panes"
  homepage "https://github.com/zdennis/work-coordinator"
  url "https://github.com/zdennis/work-coordinator/archive/refs/tags/v0.13.0.tar.gz"
  sha256 "0a62461bef32d1a0d3c2d248bd3d9afdbbeb63b4980e50254090b76e376fbc88"
  license "MIT"

  depends_on :macos
  depends_on "ruby"
  depends_on "sqlite"
  depends_on "tmux"

  def install
    # Install gems into vendor/bundle
    system "bundle", "config", "set", "--local", "path", "vendor/bundle"
    system "bundle", "config", "set", "--local", "without", "development test"
    system "bundle", "install"

    # Install with bin/ as a subdirectory so require_relative "../lib" resolves correctly
    libexec.install "lib", "db", "vendor", "Gemfile"
    (libexec/"bin").install "bin/work-coordinator"

    ruby_version = Utils.safe_popen_read(Formula["ruby"].opt_bin/"ruby",
                                        "-e", "puts RbConfig::CONFIG['ruby_version']").chomp
    gem_home = libexec/"vendor/bundle/ruby/#{ruby_version}"

    (bin/"work-coordinator").write <<~BASH
      #!/bin/bash
      export GEM_HOME="#{gem_home}"
      export GEM_PATH="#{gem_home}"
      exec "#{Formula["ruby"].opt_bin}/ruby" "#{libexec}/bin/work-coordinator" "$@"
    BASH
  end

  test do
    assert_match "work-coordinator", shell_output("#{bin}/work-coordinator --help")
  end
end
