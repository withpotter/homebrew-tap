# withpotter/homebrew-tap

Homebrew tap for Potter command-line tools.

## Box CLI

```sh
brew tap withpotter/tap
brew install withpotter/tap/box
```

Box is distributed as a Homebrew **cask** (a prebuilt bundle), so installing it
needs **no GitHub authentication, no compiler, and no Node toolchain upgrade** —
it runs on the Node.js (20 or newer) you already have on your `PATH`.

> If `box` reports that Node is missing, install it from <https://nodejs.org> or
> run `brew install node`.

After install:

```sh
box create my-box --control-plane <your-control-plane-url>
cd my-box
box activate <license-key>
box install
box start my-box 4000 3010
box deploy
```

## Source

The cask in [`Casks/box.rb`](Casks/box.rb) is generated from the Box CLI repo.
For the CLI source, full documentation, and the other install paths (curl /
PowerShell / npm), see **[withpotter/box-cli](https://github.com/withpotter/box-cli)**.
