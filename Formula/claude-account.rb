class ClaudeAccount < Formula
  desc "Per-project & global account isolation for Claude Code CLI"
  homepage "https://github.com/hunhee98/claude-account"
  url "https://github.com/hunhee98/claude-account/archive/refs/tags/v1.0.9.tar.gz"
  sha256 "3df57cde853cfbe203adafa9ad8a522e0c5e4036679e0bbfc337c31d14086882"
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
