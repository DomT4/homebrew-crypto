class Secp256k1 < Formula
  desc "Optimized C library for EC operations on curve secp256k1"
  homepage "https://github.com/bitcoin-core/secp256k1"
  url "https://github.com/bitcoin-core/secp256k1.git",
      :revision => "9e5939d2848df5508e3a6eb038273b28d255248c"
  version "0.0.0.58" # Fake version number to make updates easier.
  head "https://github.com/bitcoin-core/secp256k1.git"

  option "without-enable-module-recovery", "Disable ECDSA pubkey recovery module"

  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "gmp"

  def install
    args = %W[
      prefix=#{prefix}
      --disable-silent-rules
    ]
    args << "--enable-module-recovery" if build.with? "enable-module-recovery"

    system "./autogen.sh"
    system "./configure", *args
    system "make"
    system "make", "check"
    system "make", "install"
  end
end
