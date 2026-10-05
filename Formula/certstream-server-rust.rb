# Formula for a Homebrew tap. Copy to reloading01/homebrew-tap as
# Formula/certstream-server-rust.rb; the release workflow rewrites the
# version and the four sha256 lines on every tag.
class CertstreamServerRust < Formula
  desc "Certificate Transparency log streaming server"
  homepage "https://certstream.dev"
  version "1.6.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/reloading01/certstream-server-rust/releases/download/v#{version}/certstream-server-rust-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "5c59d27f07ab84a904f94f24d0612807c145e7a787a72ce3cfeb47a9b0ff281e"
    end
    on_intel do
      url "https://github.com/reloading01/certstream-server-rust/releases/download/v#{version}/certstream-server-rust-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "5ef5ff52bea401318be51dda06d3d0a8c9a0218f8e67bf91b87448e1a62e1c7e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/reloading01/certstream-server-rust/releases/download/v#{version}/certstream-server-rust-#{version}-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c5637d61f92f36ec613108153318150a07141f6000b54f0def9b1a0cb2f63953"
    end
    on_intel do
      url "https://github.com/reloading01/certstream-server-rust/releases/download/v#{version}/certstream-server-rust-#{version}-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e65815329d306cd67ff450b352fa17a2c509e56b55bed0fc9ca19cea24af4850"
    end
  end

  def install
    bin.install "certstream-server-rust"
    pkgshare.install "config.example.yaml"
    doc.install "README.md"
  end

  service do
    run [opt_bin/"certstream-server-rust"]
    keep_alive true
    log_path var/"log/certstream-server-rust.log"
    error_log_path var/"log/certstream-server-rust.log"
    environment_variables CERTSTREAM_CT_LOG_STATE_FILE: var/"lib/certstream/state.json"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/certstream-server-rust --version")
  end
end
