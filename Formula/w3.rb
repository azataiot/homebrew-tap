class W3 < Formula
  desc "A fast CLI for git worktrees, built for humans and coding agents who work on many branches at once."
  homepage "https://github.com/azataiot/w3"
  version "0.1.0-alpha.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/azataiot/w3/releases/download/v0.1.0-alpha.3/w3-cli-aarch64-apple-darwin.tar.xz"
      sha256 "402ed3177302dcb7cd52cd86ce45d6defad69c40270db4f9dbb69438b6a9b0c9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/azataiot/w3/releases/download/v0.1.0-alpha.3/w3-cli-x86_64-apple-darwin.tar.xz"
      sha256 "e6c612641d43adb529f5a8f3e10d9a35870e3c19f178e5b170670146c68f041f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/azataiot/w3/releases/download/v0.1.0-alpha.3/w3-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1aa62e0cfdfd592932d5cf80794f83ce2c04f3a72bf9b3c15719d4b277fcbe23"
    end
    if Hardware::CPU.intel?
      url "https://github.com/azataiot/w3/releases/download/v0.1.0-alpha.3/w3-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6d582409a17306fc3b463cca6bb78416eb1b1b4a5992146c82655ff702ad2f57"
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
