# Homebrew formula for the Box CLI.
#
# Lives in the tap repo `withpotter/homebrew-tap` as `Formula/box.rb`, so users run:
#
#   brew tap withpotter/tap
#   brew install box
#
# The `url` + `sha256` are stamped by `scripts/release.sh` against the published
# GitHub Release *bundle* (`box-bundle-<version>.tar.gz`), which already vendors
# the CLI's dependencies.
#
# We intentionally do NOT `depends_on "node"`. Box is a thin Node CLI that runs on
# whatever Node >= 20 the operator already has (the same Node their Box engine and
# console need). Declaring a Node dependency would force Homebrew to install/upgrade
# its own Node keg on every `brew install box` — which fails on machines with
# outdated Command Line Tools and is a heavy, surprising side effect for a CLI this
# small. Because the release bundle is self-contained, install is a pure file copy:
# no npm, no compiler, no network — nothing that can trip the CLT preflight.
class Box < Formula
  desc "Activate your license and run your own Box (commerce engine + console)"
  homepage "https://withpotter.com"
  url "https://github.com/withpotter/box-cli/releases/download/v0.1.0-alpha.0/box-bundle-0.1.0-alpha.0.tar.gz"
  version "0.1.0-alpha.0"
  sha256 "ade2b3c718dd3839dc29b82d995ff1336e33bd668ec6ca659f4b265a6aa79104"
  license :cannot_represent # UNLICENSED

  def install
    # The bundle already contains dist/, node_modules/, template/, assets/ and
    # package.json. Drop it into libexec and expose a small launcher on PATH that
    # runs it with the operator's own Node.
    libexec.install Dir["*"]
    (bin/"box").write <<~SH
      #!/bin/bash
      if ! command -v node >/dev/null 2>&1; then
        echo "box: Node.js is required but was not found on your PATH." >&2
        echo "     Install Node 20+ from https://nodejs.org (or 'brew install node')." >&2
        exit 1
      fi
      exec node "#{libexec}/dist/index.js" "$@"
    SH
    chmod 0755, bin/"box"
  end

  def caveats
    <<~EOS
      Box runs on your existing Node.js (20 or newer) — Homebrew does not install
      Node for you. If `box` reports that Node is missing, install it from
      https://nodejs.org or run `brew install node`.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/box --version")
  end
end
