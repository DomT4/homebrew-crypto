class Bitcoind < Formula
  homepage "https://bitcoin.org/en/"
  url "https://github.com/bitcoin/bitcoin/archive/v0.10.1.tar.gz"
  sha256 "d83e2872de37a17c60b7f5d86a5d9cfe2e7e706bf270ea59d7cd846d2fbf8102"
  head "https://github.com/bitcoin/bitcoin.git"

  option "with-gui", "Build with the GUI enabled in addition to the Daemon/CLI"

  depends_on "pkg-config" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on :xcode => :build
  depends_on "openssl"
  depends_on "boost"
  depends_on "gmp"
  depends_on "miniupnpc" => :recommended

  if build.with? "gui"
    depends_on "protobuf"
    depends_on "qt5"
    depends_on "qrencode"
    depends_on "gettext" => :recommended
  end

  resource "berkeleydb4" do
    url "http://download.oracle.com/berkeley-db/db-4.8.30.tar.gz"
    sha256 "e0491a07cdb21fb9aa82773bbbedaeb7639cbd0e7f96147ab46141e0045db72a"
  end

  def install
    resource("berkeleydb4").stage do
      ENV.deparallelize

      inreplace "dbinc/atomic.h", "__atomic_compare_exchange((p), (o), (n))", "__atomic_compare_exchange_db((p), (o), (n))"
      inreplace "dbinc/atomic.h", "static inline int __atomic_compare_exchange(", "static inline int __atomic_compare_exchange_db("

      args = ["--disable-debug",
              "--prefix=#{libexec}/berkeley-db4/4.8.30",
              "--mandir=#{libexec}/share/man/berkeley-db4/4.8.30",
              "--disable-shared",
              "--disable-replication",
              "--enable-cxx"]

      cd "build_unix" do
        system "../dist/configure", *args
        system "make"
        system "make", "install"
      end
    end

    ENV.prepend_path "PATH", "#{libexec}/berkeley-db4/4.8.30/bin"
    ENV.prepend "CPPFLAGS", "-I#{libexec}/berkeley-db4/4.8.30/include"
    ENV.prepend "LDFLAGS", "-L#{libexec}/berkeley-db4/4.8.30/lib"

    args = ["--prefix=#{libexec}", "--disable-dependency-tracking"]

    if build.with? "gui"
      args << "--with-qrencode"
      args << "--with-gui=qt5"
    end

    args << "--with-miniupnpc" if build.with? "miniupnpc"

    system "./autogen.sh"
    system "./configure", *args
    system "make"
    system "make", "check"
    system "make", "install"
    bin.write_exec_script Dir["#{libexec}/bin/*"]
  end

  def caveats; <<-EOS.undent
    Bitcoind will need to set up bitcoin.conf on first-run. You can manually do this with:

      echo -e "rpcuser=bitcoinrpc\\nrpcpassword=$(xxd -l 16 -p /dev/urandom)" > ~/Library/Application\\ Support/Bitcoin/bitcoin.conf
      chmod 600 ~/Library/Application\\ Support/Bitcoin/bitcoin.conf

    Or automatically by running 'bitcoind' in your Terminal application, which will provide you instructions.
    EOS
  end
end
