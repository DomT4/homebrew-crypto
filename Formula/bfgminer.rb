class Bfgminer < Formula
  desc "Modular ASIC/FPGA miner written in C"
  homepage "https://github.com/luke-jr/bfgminer"
  url "http://luke.dashjr.org/programs/bitcoin/files/bfgminer/5.4.2/bfgminer-5.4.2.zip"
  sha256 "9be4b7374ee90751cf221ff3cf8b697a5f3034b11aedb6ffbae0911e3560412c"

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

    ENV.append_to_cflags "-I#{buildpath}/uthash/include"
    args = %W[
      --prefix=#{prefix}
      --disable-debug
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-opencl
      --without-system-libbase58
    ]

    args << "--enable-scrypt" if build.with? "scrypt"
    args << "--enable-keccak" if build.with? "keccak"
    args << "--enable-cpumining" if build.with? "cpumining"

    system "./configure", *args
    system "make", "install"
  end

  test do
    system bin/"bfgminer", "--version"
  end
end
