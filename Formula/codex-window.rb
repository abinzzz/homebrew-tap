class CodexWindow < Formula
  desc "Start Codex five-hour usage windows with one tiny Luna turn"
  homepage "https://github.com/abinzzz/codex-window"
  url "https://github.com/abinzzz/codex-window/releases/download/v0.1.0/codex-window-0.1.0.tar.gz"
  sha256 "323134b038735cf7c35fe204b6de80b1dfda8d46d6d0d8d97d5c6e931ed53aea"
  license "MIT"

  depends_on "python@3.13"

  def install
    libexec.install "codex_window"
    (bin/"codex-window").write <<~PYTHON
      #!#{Formula["python@3.13"].opt_bin}/python3.13
      import sys
      sys.path.insert(0, #{libexec.to_s.inspect})
      from codex_window.cli import main
      raise SystemExit(main())
    PYTHON
  end

  service do
    run [opt_bin/"codex-window", "watch"]
    keep_alive true
    environment_variables PATH: "#{HOMEBREW_PREFIX}/bin:/usr/local/bin:/usr/bin:/bin"
    log_path var/"log/codex-window.log"
    error_log_path var/"log/codex-window.error.log"
  end

  def caveats
    <<~EOS
      Requires the official Codex CLI and a ChatGPT login:
        codex login
        codex-window status
        codex-window run --dry-run

      Start automatic window initialization explicitly:
        brew services start codex-window
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/codex-window --version").strip
    assert_match "status", shell_output("#{bin}/codex-window --help")
  end
end
