class Secp256k1  < Formula
  homepage "https://github.com/bitcoin/secp256k1"
  url "https://github.com/bitcoin/secp256k1.git", :revision => "f789c5baf2b2155397fbbfb4e27540ff1195575e"
  version "0.0.0.9" # Fake version number to make updates easier.
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
