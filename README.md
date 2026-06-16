# withpotter/homebrew-tap

Homebrew tap for Potter command-line tools.

## Box CLI

```sh
brew tap withpotter/tap
brew install box
```

> The Box CLI is distributed from a private GitHub release. If `brew install`
> can't fetch the bottle/tarball, authenticate Homebrew to GitHub first:
> `export HOMEBREW_GITHUB_API_TOKEN=<token>` (a token with `repo` read access).

After install:

```sh
box create my-box --control-plane <your-control-plane-url>
cd my-box
box activate <license-key>
box install
box start my-box 4000 3010
box deploy
```
