require "formula"

# TrueCrypt ported to wxWidgets 3.0, and some patches to build a 64-bit version on OS X.
# Original work by the Truecrypt Foundation.
# Work on porting the program to 64-bit & wxwidgets 3.0 done by "neurodroid" here:
# https://github.com/neurodroid/TrueCrypt
# That has hardcoded paths to MacPorts, which I tweaked in my fork to work for Brew.

class Truecrypt < Formula
   homepage "https://github.com/DomT4/truecrypt-homebrew"
   url "https://github.com/DomT4/truecrypt-homebrew/releases/download/v1.1/Truecryptv1-1.tar.gz"
   sha256 "8c302dde0c126eebd45cf3d0e886688b6d2668b055ce37ab7690ec69af70acd6"
   version "1.1"

   option "with-cli-only", "Build only the Truecrypt CLI"

   depends_on "pkg-config" => :build
   depends_on "nasm" => :build
   depends_on "wxmac"
   depends_on :osxfuse

  def install
    args = ["-j#{ENV.make_jobs}"]

    args << "NOGUI=1" if build.with? "cli-only"

    system "make", *args
    bin.install "main/TrueCrypt"
    share.install "TrueCrypt_User_Guide.pdf"
    share.install "License.txt"
    prefix.install "main/TrueCrypt.app" if build.without? "cli-only"
  end

  test do
    system "#{bin}/truecrypt", "--version" if build.with? "cli-only"
  end
end
