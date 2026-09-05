class W3 < Formula
  desc "A fast CLI for git worktrees, built for humans and coding agents who work on many branches at once."
  homepage "https://github.com/azataiot/w3"
  version "0.1.0-alpha.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/azataiot/w3/releases/download/v0.1.0-alpha.1/w3-cli-aarch64-apple-darwin.tar.xz"
      sha256 "c458ad1f120d2f347b1bfe13880921b7153c65bd9c249881266102bad6d3e9d2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/azataiot/w3/releases/download/v0.1.0-alpha.1/w3-cli-x86_64-apple-darwin.tar.xz"
      sha256 "b40190f28340f54a8d8c8bb98235ad95b38b888f868036bc34a1d09b51ead905"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/azataiot/w3/releases/download/v0.1.0-alpha.1/w3-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6a5e9ba74452819bd24ce52bf381899c581d9d4c6c7acf702cd50656a9b428b3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/azataiot/w3/releases/download/v0.1.0-alpha.1/w3-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "276f6e60a54d5019d6abe008c147117423e100f60ab0b1245d24426f5e9201fa"
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
