class W3 < Formula
  desc "A fast CLI for git worktrees, built for humans and coding agents who work on many branches at once."
  homepage "https://github.com/azataiot/w3"
  version "0.1.0-alpha.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/azataiot/w3/releases/download/v0.1.0-alpha.2/w3-cli-aarch64-apple-darwin.tar.xz"
      sha256 "c937c7cda8b4f8a5b3aac72722081325f588894fcb043e512b256fb5faca90bc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/azataiot/w3/releases/download/v0.1.0-alpha.2/w3-cli-x86_64-apple-darwin.tar.xz"
      sha256 "e0ca50612a209b23b82c7d48b1ff30a6decf9968d8b54cae91a884a717de3cd3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/azataiot/w3/releases/download/v0.1.0-alpha.2/w3-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "84d6da3008b2f3061462a0246c63ca5b058d66935635ef506430caedcbe74649"
    end
    if Hardware::CPU.intel?
      url "https://github.com/azataiot/w3/releases/download/v0.1.0-alpha.2/w3-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bcaceb716cee631101f8b9424aa3cd17101eb36133ccd2cfd85647d14e6c2039"
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
