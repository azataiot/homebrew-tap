class W3 < Formula
  desc "A fast CLI for git worktrees, built for humans and coding agents who work on many branches at once."
  homepage "https://github.com/azataiot/w3"
  version "0.1.0-alpha.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/azataiot/w3/releases/download/v0.1.0-alpha.4/w3-cli-aarch64-apple-darwin.tar.xz"
      sha256 "4df3c18bb9f245ca75bbfa2882a6ff614b8049d260c059e989784207c534c2dd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/azataiot/w3/releases/download/v0.1.0-alpha.4/w3-cli-x86_64-apple-darwin.tar.xz"
      sha256 "7cb74033bbc13537cd149ba217184c9c5f5d4baf990a6397194261d4fdfb42f7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/azataiot/w3/releases/download/v0.1.0-alpha.4/w3-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "431ce7468c120f14d7aaecbb30c5e4eec4713d8a4db03bf8c8a3a5a4e78eb880"
    end
    if Hardware::CPU.intel?
      url "https://github.com/azataiot/w3/releases/download/v0.1.0-alpha.4/w3-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4534c22e85b755df9b9b13db061e03771f22e1f6bcc734d7e66678a04886c5ba"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "w3"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "w3"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "w3"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "w3"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
