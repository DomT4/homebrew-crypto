class Secp256k1 < Formula
  desc "Optimized C library for EC operations on curve secp256k1"
  homepage "https://github.com/bitcoin-core/secp256k1"
  url "https://github.com/bitcoin-core/secp256k1.git",
      revision: "ac83be33d0956faf6b7f61a60ab524ef7d6a473a"
  version "0.0.0.64" # Fake version number to make updates easier.
  head "https://github.com/bitcoin-core/secp256k1.git"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "gmp"

  def install
    system "./autogen.sh"
    system "./configure", "prefix=#{prefix}", "--disable-silent-rules", "--enable-dev-mode"
    system "make"
    system "make", "check"
    system "make", "install"
    libexec.install Dir["*_example"]
  end

  test do
    assert_match "Is the signature valid? true", shell_output(libexec/"schnorr_example")
  end
end
