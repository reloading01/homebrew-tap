# Formula for a Homebrew tap. Copy to reloading01/homebrew-tap as
# Formula/certstream-server-rust.rb; the release workflow rewrites the
# version and the four sha256 lines on every tag.
class CertstreamServerRust < Formula
  desc "Certificate Transparency log streaming server"
  homepage "https://certstream.dev"
  version "1.7.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/reloading01/certstream-server-rust/releases/download/v#{version}/certstream-server-rust-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "7d8c8565a43387828dfa77fc85ecf16f2c41494ec0e6d27e2636c2762aa8df86"
    end
    on_intel do
      url "https://github.com/reloading01/certstream-server-rust/releases/download/v#{version}/certstream-server-rust-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "dc80a53d0621b2fceccdf3d9978bdfe53fa1d1cde940296f59e90e31eaa0d9ec"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/reloading01/certstream-server-rust/releases/download/v#{version}/certstream-server-rust-#{version}-aarch64-unknown-linux-musl.tar.gz"
      sha256 "50b2cdf80cdf85a775182e22670ba3ef3ab7b204c2a670a54135c38de48be4bf"
    end
    on_intel do
      url "https://github.com/reloading01/certstream-server-rust/releases/download/v#{version}/certstream-server-rust-#{version}-x86_64-unknown-linux-musl.tar.gz"
      sha256 "89ec11e01b69e37140051b271cc58ef0d547ea83161908e348a1263450c4365f"
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
