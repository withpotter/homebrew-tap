# Homebrew formula for the Box CLI.
#
# Lives in the tap repo `withpotter/homebrew-tap` as `Formula/box.rb`, so users run:
#
#   brew tap withpotter/tap
#   brew install box
#
# The `url` + `sha256` are stamped by `scripts/release.sh` against the published
# GitHub Release tarball. Homebrew installs the Node package into libexec and
# links the `box` binary onto PATH; `node` is pulled in as a dependency.
class Box < Formula
  desc "Activate your license and run your own Box (commerce engine + console)"
  homepage "https://withpotter.com"
  url "https://github.com/withpotter/box-cli/releases/download/v0.1.0-alpha.0/withpotter-box-0.1.0-alpha.0.tgz"
  version "0.1.0-alpha.0"
  sha256 "66ac3233d287c2f7cf191236bac9a4270ae531a7ea3531c46d40fd16915d5f9e"
  license :cannot_represent # UNLICENSED

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/box --version")
  end
end
