class Secp256k1  < Formula
  homepage "https://github.com/bitcoin/secp256k1"
  url "https://github.com/bitcoin/secp256k1.git", :revision => "2d4cd53087227c55451ba7d2de24044379e62f3c"
  version "0.0.0.6" # Fake version number to make updates easier.
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
