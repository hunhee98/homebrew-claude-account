class ClaudeAccount < Formula
  desc "Per-project & global account isolation for Claude Code CLI"
  homepage "https://github.com/hunhee98/claude-account"
  url "https://github.com/hunhee98/claude-account/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "4d9bb5056773e42796d3b0d31fcd5f0985918c330d7b28851b3b72ed2ada7dcf"
  license "MIT"

  depends_on "gum"

  def install
    pkgshare.install "claude-account.sh"
  end

  def post_install
    zshrc      = "#{ENV["HOME"]}/.zshrc"
    marker     = "# claude-account"
    source_line = "source #{pkgshare}/claude-account.sh"
    accounts   = "#{ENV["HOME"]}/.claude-accounts"
    homes      = "#{ENV["HOME"]}/.claude-homes"
    claude     = "#{ENV["HOME"]}/.claude"
    current    = "#{accounts}/.current"

    FileUtils.mkdir_p(accounts)
    FileUtils.mkdir_p(homes)

    FileUtils.touch(zshrc) unless File.exist?(zshrc)
    unless File.read(zshrc).include?(marker)
      File.open(zshrc, "a") do |f|
        f.puts "\n#{marker}"
        f.puts source_line
      end
    end

    if Dir.exist?(claude) && !File.exist?(current)
      dest = "#{accounts}/default"
      FileUtils.cp_r(claude, dest)
      FileUtils.mkdir_p("#{homes}/default")
      File.symlink(dest, "#{homes}/default/.claude") unless File.exist?("#{homes}/default/.claude")
      File.write(current, "default")
    end
  end

  def caveats
    <<~EOS
      Run the following to apply:
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
