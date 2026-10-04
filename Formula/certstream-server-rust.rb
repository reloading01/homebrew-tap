# Formula for a Homebrew tap. Copy to reloading01/homebrew-tap as
# Formula/certstream-server-rust.rb; the release workflow rewrites the
# version and the four sha256 lines on every tag.
class CertstreamServerRust < Formula
  desc "Certificate Transparency log streaming server"
  homepage "https://certstream.dev"
  version "1.6.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/reloading01/certstream-server-rust/releases/download/v#{version}/certstream-server-rust-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "1635e6971fabb2e00de476b5d9ac5fb3d258ef86e13e9f7fb72edfde6f716f6f"
    end
    on_intel do
      url "https://github.com/reloading01/certstream-server-rust/releases/download/v#{version}/certstream-server-rust-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "24329904f6fd2a913c65c95a7667aa6fd96c88aae18864eccd9e79f672cbce7e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/reloading01/certstream-server-rust/releases/download/v#{version}/certstream-server-rust-#{version}-aarch64-unknown-linux-musl.tar.gz"
      sha256 "785cabccf88ccbba9e7fb8dbcfc17eeffbc919c68b8acf30570b4c4b105e1b42"
    end
    on_intel do
      url "https://github.com/reloading01/certstream-server-rust/releases/download/v#{version}/certstream-server-rust-#{version}-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d0b76674833cbae70c7102018df292b2f08ef624fac9fb71b537d7e4068abeee"
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
