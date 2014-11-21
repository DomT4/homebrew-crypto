require "formula"

# TrueCrypt ported to wxWidgets 3.0, and some patches to build a 64-bit version on OS X.
# Original work by the Truecrypt Foundation.
# Work on porting the program to 64-bit & wxwidgets 3.0 done by "neurodroid" here:
# https://github.com/neurodroid/TrueCrypt
# That has hardcoded paths to MacPorts, which I tweaked in my fork to work for Brew.

class Truecrypt < Formula
   homepage "https://github.com/DomT4/truecrypt-homebrew"
   url "https://github.com/DomT4/truecrypt-homebrew/archive/v1.0.tar.gz"
   sha256 "c2b33ef523325d0e1d9eb78baffab6e59f0cff510c017ff4f8a038796caf538b"

   depends_on "pkg-config" => :build
   depends_on "nasm" => :build
   depends_on "wxmac"
   depends_on :osxfuse

  def install
    system "make"
    bin.install "main/TrueCrypt"
    prefix.install "main/TrueCrypt.app"
  end
end
