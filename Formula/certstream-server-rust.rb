# Formula for a Homebrew tap. Copy to reloading01/homebrew-tap as
# Formula/certstream-server-rust.rb; the release workflow rewrites the
# version and the four sha256 lines on every tag.
class CertstreamServerRust < Formula
  desc "Certificate Transparency log streaming server"
  homepage "https://certstream.dev"
  version "1.7.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/reloading01/certstream-server-rust/releases/download/v#{version}/certstream-server-rust-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "f962cf1c6baee9ec84e801113ef2f3dc01bac1fc6a64a6f91f58e9b701f1dd91"
    end
    on_intel do
      url "https://github.com/reloading01/certstream-server-rust/releases/download/v#{version}/certstream-server-rust-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "4de6b965a35b533437c6400b4d32715d57608afe0d8438b1b2722174d5375e53"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/reloading01/certstream-server-rust/releases/download/v#{version}/certstream-server-rust-#{version}-aarch64-unknown-linux-musl.tar.gz"
      sha256 "71800a27b9e47e968bd9263719753c8c94da4d40ac386ca3669e455dbbb1a5d0"
    end
    on_intel do
      url "https://github.com/reloading01/certstream-server-rust/releases/download/v#{version}/certstream-server-rust-#{version}-x86_64-unknown-linux-musl.tar.gz"
      sha256 "1bae81ea793172e9bbc44451c5ddd5852fed8e435c5372bc2de4ed09f26a34bb"
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
