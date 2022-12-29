class Libsecp256k1 < Formula
  desc "Optimized C library for EC operations on curve secp256k1"
  homepage "https://github.com/bitcoin-core/secp256k1"
  url "https://github.com/bitcoin-core/secp256k1/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "6cb0fd596e6b1a671f96e9ed7e65a047960def73de024e7b39f45a78ab4fc8df"
  license "MIT"
  head "https://github.com/bitcoin-core/secp256k1.git"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "gmp"

  keg_only "this formula installs the same core libraries as the formula in homebrew/core"

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
