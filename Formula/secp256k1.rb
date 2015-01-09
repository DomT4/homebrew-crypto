class Secp256k1  < Formula
  homepage "https://github.com/bitcoin/secp256k1"
  # Deps are moving around so much specify a commit to build up to, and refresh manually every few days.
  url "https://github.com/bitcoin/secp256k1.git", :revision => "50cc6ab0625efda6dddf1dc86c1e2671f069b0d8"
  version "0.0.0.3" # Fake version number to make updates easier.
  head "https://github.com/bitcoin/secp256k1.git"

  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "gmp"
  depends_on "openssl"

  def install
    system "./autogen.sh"
    system "./configure", "prefix=#{prefix}", "--disable-silent-rules"
    system "make", "install"
  end
end
