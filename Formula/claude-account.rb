class ClaudeAccount < Formula
  desc "Per-project & global account isolation for Claude Code CLI"
  homepage "https://github.com/hunhee98/claude-account"
  url "https://github.com/hunhee98/claude-account/archive/refs/tags/v1.0.15.tar.gz"
  sha256 "b40cb1ecc989464ab2d33f76fe073fcb436a47c2cd52681af7e6175c44049d32"
  license "MIT"

  depends_on "gum"

  def install
    pkgshare.install "claude-account.sh"
  end

  def caveats
    <<~EOS
      To complete setup, add the following to your ~/.zshrc:

        source $(brew --prefix)/share/claude-account/claude-account.sh

      Then run:

        source ~/.zshrc

      Usage:
        claude account          Switch accounts
        claude account add      Add a new account
        claude account status   Show current account
    EOS
  end

  test do
    assert_match "Usage", shell_output("zsh -c 'source #{pkgshare}/claude-account.sh && claude account help 2>&1'")
  end
end
