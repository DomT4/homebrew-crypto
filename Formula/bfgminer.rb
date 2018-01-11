class Bfgminer < Formula
  desc "Modular ASIC/FPGA miner written in C"
  homepage "https://github.com/luke-jr/bfgminer"
  url "http://bfgminer.org/files/5.5.0/bfgminer-5.5.0.txz"
  sha256 "ac254da9a40db375cb25cacdd2f84f95ffd7f442e31d2b9a7f357a48d32cc681"

  option "with-cpumining", "Build with cpumining support"

  depends_on "pkg-config" => :build
  depends_on "yasm" => :build
  depends_on "curl" => :recommended
  depends_on "hidapi"
  depends_on "jansson"
  depends_on "libmicrohttpd"
  depends_on "libevent"
  depends_on "libusb"

  resource "uthash" do
    url "https://github.com/troydhanson/uthash/archive/v2.0.2.tar.gz"
    sha256 "34a31d51dd7a839819cecd6f46049b4ffe031d7f3147d9a042f5504fdb1348d1"
  end

  def install
    resource("uthash").stage do
      (buildpath/"uthash/include").install Dir["src/*.h"]
    end
    ENV.append_to_cflags "-I#{buildpath}/uthash/include"

    args = %W[
      --prefix=#{prefix}
      --disable-debug
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-keccak
      --enable-opencl
      --enable-scrypt
      --without-system-libbase58
    ]
    args << "--enable-cpumining" if build.with? "cpumining"

    system "./configure", *args
    system "make", "install"
  end

  test do
    system bin/"bfgminer", "--version"
  end
end
