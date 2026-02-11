class Bwenv < Formula
  desc "Bitwarden + direnv helper — sync secrets from Bitwarden into your shell environment"
  homepage "https://github.com/s1ks1/bwenv"
  url "https://github.com/s1ks1/bwenv/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "a169d17e55fb69c0291cfa90af2daec370eba48e83cacf12da5ebea4e19bde7c"
  license "MIT"

  depends_on "bitwarden-cli"
  depends_on "direnv"
  depends_on "jq"

  def install
    (etc/"direnv/lib").install "setup/bitwarden_folders.sh"
    bin.install "setup/bwenv"
  end

  def post_install
    # Create user-level direnv lib symlink if needed
    user_lib = Pathname.new(Dir.home)/".config/direnv/lib"
    user_lib.mkpath
    target = user_lib/"bitwarden_folders.sh"
    unless target.exist?
      target.make_symlink(etc/"direnv/lib/bitwarden_folders.sh")
    end
  end

  def caveats
    <<~EOS
      Ensure direnv is hooked into your shell:
        bash: eval "$(direnv hook bash)"
        zsh:  eval "$(direnv hook zsh)"
        fish: direnv hook fish | source

      Run 'bwenv test' to verify your setup.
    EOS
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/bwenv 2>&1", 0)
  end
end


