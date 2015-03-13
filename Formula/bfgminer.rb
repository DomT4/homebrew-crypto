class Bfgminer < Formula
  homepage "https://github.com/luke-jr/bfgminer"
  url "http://luke.dashjr.org/programs/bitcoin/files/bfgminer/5.1.x/bfgminer-5.1.0.zip"
  sha256 "7b56f7f59dbb019972641dc252372c5235e0b6433bdcfd6f6966d3087346bbe2"

  option "without-scrypt", "Build without Scrypt support"
  option "with-keccak", "Build with Keccak support"
  option "with-cpumining", "Build with cpumining support"

  depends_on "pkg-config" => :build
  depends_on "curl" => :recommended
  depends_on "hidapi"
  depends_on "jansson"
  depends_on "libmicrohttpd"
  depends_on "libevent"
  depends_on "libusb"

  resource "uthash" do
    url "https://github.com/troydhanson/uthash/archive/v1.9.9.tar.gz"
    sha256 "f2f10115f4de03b98d8c2e860e241d165aa15019bd634ee0e3debe58341bbf0c"
  end

  def install
    resource("uthash").stage do
      (buildpath/"uthash/include").install "src/utarray.h", "src/uthash.h", "src/utlist.h", "src/utstring.h"
    end

    args = %W[
      --prefix=#{prefix}
      --disable-debug
      --disable-dependency-tracking
      --enable-opencl
      --without-system-libbase58
    ]

    args << "--enable-scrypt" if build.with? "scrypt"
    args << "--enable-keccak" if build.with? "keccak"
    args << "--enable-cpumining" if build.with? "cpumining"

    ENV.append_to_cflags "-I#{buildpath}/uthash/include"

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "bfgminer", "--version"
  end
end
