class ClaudeAccount < Formula
  desc "Per-project & global account isolation for Claude Code CLI"
  homepage "https://github.com/hunhee98/claude-account"
  url "https://github.com/hunhee98/claude-account/archive/refs/tags/v1.0.8.tar.gz"
  sha256 "ff43e999526063f480ad98dc879c5d856d58a8b1eb807fd9d7ac5c4b954d74d0"
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
