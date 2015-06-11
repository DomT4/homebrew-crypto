class Bfgminer < Formula
  desc "Modular ASIC/FPGA miner written in C"
  homepage "https://github.com/luke-jr/bfgminer"
  url "http://luke.dashjr.org/programs/bitcoin/files/bfgminer/5.2.x/bfgminer-5.2.0.zip"
  sha256 "6b3e055fdf79468dbb5306c8657de3c956d2e535c8d5b2713b0c30ee38c4cca5"

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
