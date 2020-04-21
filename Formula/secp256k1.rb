class Secp256k1 < Formula
  desc "Bitcoin experimental curves library"
  homepage "https://github.com/bitcoin-core/secp256k1"
  url "https://github.com/bitcoin-core/secp256k1.git",
      :revision => "39198a03eaa33d5902b16d3aefa7c441232f60fb"
  version "0.0.0.55" # Fake version number to make updates easier.
  head "https://github.com/bitcoin-core/secp256k1.git"

  option "with-enable-module-recovery", "Enable ECDSA pubkey recovery module"

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
