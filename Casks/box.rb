# Homebrew Cask for the Box CLI.
#
# Lives in the tap repo `withpotter/homebrew-tap` as `Casks/box.rb`, so users run:
#
#   brew tap withpotter/tap
#   brew install --cask box       # or simply: brew install withpotter/tap/box
#
# We ship Box as a CASK, not a Formula, on purpose. Box is a prebuilt Node CLI; a
# formula from a custom tap has no bottle, so Homebrew treats it as a source build
# and runs its Xcode/Command-Line-Tools preflight — which refuses to install on any
# machine whose CLT is older than the current macOS, even though Box compiles
# nothing. Casks install prebuilt artifacts and skip that preflight entirely. The
# release bundle vendors all dependencies, and the launcher runs on the operator's
# existing Node (20+), so no compiler and no Node toolchain are ever required.
#
# `url` + `sha256` are stamped by `scripts/release.sh` against the published bundle.
cask "box" do
  version "0.1.0-alpha.39"
  sha256 "648c9c87b36571341f0d5d58cae6077583aac6f0ace1c669f339f13a1d9b1d99"

  url "https://github.com/withpotter/box-distribution/releases/download/v#{version}/box-bundle-#{version}.tar.gz"
  name "Box CLI"
  desc "Activate your license and run your own Box (commerce engine + console)"
  homepage "https://github.com/withpotter/box-distribution"

  # The bundle extracts to a single staging directory containing dist/,
  # node_modules/, template/, assets/ and the `box` launcher. Symlink the launcher
  # onto PATH; it locates the bundle and runs it with the operator's Node.
  binary "box"

  caveats <<~EOS
    Box runs on your existing Node.js (20 or newer) — Homebrew does not install
    Node for you. If `box` reports that Node is missing, install it from
    https://nodejs.org or run `brew install node`.
  EOS
end
