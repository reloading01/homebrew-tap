# homebrew-tap

Homebrew formulae for [certstream-server-rust](https://github.com/reloading01/certstream-server-rust).

```bash
brew install reloading01/tap/certstream-server-rust
```

That installs a prebuilt binary; nothing is compiled locally. Formulae here are
updated automatically by the release workflow in the main repository, so the
version tracks the latest release.

To run it as a background service:

```bash
brew services start certstream-server-rust
```

The server needs no configuration to start. It discovers the Certificate
Transparency logs, serves WebSocket on `:8080`, and keeps its log positions
under Homebrew's `var` directory so a restart resumes rather than replays.
Settings are documented at [certstream.dev/docs.html](https://certstream.dev/docs.html).
