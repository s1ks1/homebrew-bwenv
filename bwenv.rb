class Bwenv < Formula
  desc "Sync secrets from password managers (Bitwarden, 1Password) into your shell via direnv"
  homepage "https://github.com/s1ks1/bwenv"
  url "https://github.com/s1ks1/bwenv/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "7a79df1a917f228f22ed091453d18349c95759bb782cd83fa3139c4436d19b91"
  license "MIT"

  depends_on "direnv"
  depends_on "bitwarden-cli", optional: true
  depends_on "1password-cli", optional: true

  def install
    bin.install "bwenv"
  end

  def caveats
    <<~EOS
      To get started, run:

        bwenv status

      Make sure direnv is hooked into your shell:
        bash: eval "$(direnv hook bash)"
        zsh:  eval "$(direnv hook zsh)"
        fish: direnv hook fish | source
    EOS
  end

  test do
    assert_match "bwenv #{version}", shell_output("#{bin}/bwenv version", 0)
  end
end
