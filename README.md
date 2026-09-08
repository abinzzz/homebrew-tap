# abinzzz Homebrew Tap

```sh
brew tap abinzzz/tap
brew install codex-window
```

[codex-window](https://github.com/abinzzz/codex-window) monitors Codex five-hour resets and starts confirmed unstarted windows with one tiny Luna turn.

```sh
codex-window status
codex-window run --dry-run
brew services start codex-window
brew services stop codex-window
```

Codex CLI and ChatGPT login must be configured separately. Installation does not start the service.
