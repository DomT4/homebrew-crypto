class Secp256k1 < Formula
  desc "Bitcoin experimental curves library"
  homepage "https://github.com/bitcoin/secp256k1"
  url "https://github.com/bitcoin/secp256k1.git",
      :revision => "b8c26a39903de7bf1d789232e030319116b011ac"
  version "0.0.0.38" # Fake version number to make updates easier.
  head "https://github.com/bitcoin/secp256k1.git"

  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "gmp"

  def install
    system "./autogen.sh"
    system "./configure", "prefix=#{prefix}", "--disable-silent-rules"
    system "make"
    system "./tests"
    system "make", "install"
  end
end
