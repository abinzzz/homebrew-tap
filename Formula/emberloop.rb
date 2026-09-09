class Emberloop < Formula
  desc "Start Codex five-hour usage windows with one tiny Luna turn"
  homepage "https://github.com/abinzzz/emberloop"
  url "https://github.com/abinzzz/emberloop/releases/download/v0.2.0/emberloop-0.2.0.tar.gz"
  sha256 "744e883e234b057923ae18dacf48a55cd94c3d25472f44951cedacb79b20460b"
  license "MIT"

  bottle do
    root_url "https://github.com/abinzzz/homebrew-tap/releases/download/emberloop-0.2.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "61896eef9dfa73b6b866bba28b814289da2631170a8bba03bb26332fabf126b5"
  end

  depends_on "python@3.13"

  def install
    libexec.install "codex_window"
    (bin/"emberloop").write <<~PYTHON
      #!/usr/bin/env python3.13
      import sys
      from pathlib import Path
      sys.path.insert(0, str(Path(__file__).resolve().parents[1]/"libexec"))
      from codex_window.cli import main
      raise SystemExit(main())
    PYTHON
  end

  service do
    run [opt_bin/"emberloop", "watch"]
    keep_alive true
    environment_variables PATH: "#{HOMEBREW_PREFIX}/bin:/usr/local/bin:/usr/bin:/bin"
    log_path var/"log/emberloop.log"
    error_log_path var/"log/emberloop.error.log"
  end

  def caveats
    <<~EOS
      Requires the official Codex CLI and a ChatGPT login:
        codex login
        emberloop status
        emberloop run --dry-run

      Start automatic window initialization explicitly:
        brew services start emberloop
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/emberloop --version").strip
    assert_match "status", shell_output("#{bin}/emberloop --help")
  end
end
