class Secp256k1 < Formula
  desc "Bitcoin experimental curves library"
  homepage "https://github.com/bitcoin-core/secp256k1"
  url "https://github.com/bitcoin-core/secp256k1.git",
      :revision => "ef83281c3a264e8346cb3c9d0db233b86a881663"
  version "0.0.0.54" # Fake version number to make updates easier.
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
    # Workaround for https://github.com/bitcoin-core/secp256k1/issues/674
    if MacOS.version == :catalina
      args << "CC=clang"
      args << "CFLAGS=-mmacosx-version-min=10.15"
      args << "LDFLAGS=-Wl,-bind_at_load"
    end
    args << "--enable-module-recovery" if build.with? "enable-module-recovery"

    system "./autogen.sh"
    system "./configure", *args
    system "make"
    system "make", "check"
    system "make", "install"
  end
end
