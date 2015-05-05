class Dogecoin < Formula
  homepage "http://dogecoin.com/"
  url "https://github.com/dogecoin/dogecoin/archive/v1.8.2.tar.gz"
  sha256 "87060dfe6d9770f8af17c447120cb6a059bbd84687dfd6a1f0787c9d75d75d9e"
  head "https://github.com/dogecoin/dogecoin.git"

  option "with-gui", "Build with the GUI enabled in addition to the Daemon/CLI"

  depends_on "pkg-config" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on :xcode => :build
  depends_on "openssl"
  depends_on "homebrew/versions/boost155"
  depends_on "miniupnpc" => :recommended

  if build.with? "gui"
    depends_on "qt"
    depends_on "protobuf"
    depends_on "qrencode"
    depends_on "gettext" => :recommended
  end

  resource "berkeleydb51" do
    url "http://download.oracle.com/berkeley-db/db-5.1.29.tar.gz"
    sha256 "a943cb4920e62df71de1069ddca486d408f6d7a09ddbbb5637afe7a229389182"
  end

  def install
    resource("berkeleydb51").stage do
      ENV.deparallelize

      inreplace "src/dbinc/atomic.h", "__atomic_compare_exchange((p), (o), (n))", "__atomic_compare_exchange_db((p), (o), (n))"
      inreplace "src/dbinc/atomic.h", "static inline int __atomic_compare_exchange(", "static inline int __atomic_compare_exchange_db("

      args = ["--disable-debug",
              "--prefix=#{libexec}/berkeley-db/5.1.29",
              "--mandir=#{libexec}/share/man/berkeley-db/5.1.29",
              "--disable-shared",
              "--disable-replication",
              "--enable-cxx"]

      cd "build_unix" do
        system "../dist/configure", *args
        system "make"
        system "make", "install"
      end
    end

    ENV.prepend_path "PATH", "#{libexec}/berkeley-db/5.1.29/bin"
    ENV.prepend "CPPFLAGS", "-I#{libexec}/berkeley-db/5.1.29/include"
    ENV.prepend "LDFLAGS", "-L#{libexec}/berkeley-db/5.1.29/lib"
    system "./autogen.sh"

    args = ["--prefix=#{libexec}", "--disable-dependency-tracking"]

    if build.with? "gui"
      args << "--with-qrencode"
      args << "--with-gui"
    end

    args << "--with-miniupnpc" if build.with? "miniupnpc"

    system "./configure", *args
    system "make"
    system "make", "check"
    system "make", "install"
    bin.write_exec_script Dir["#{libexec}/bin/*"]
  end

  def caveats; <<-EOS.undent
    Dogecoin will need to set up dogecoin.conf on first-run.

    This will automatically happen by running 'dogecoind' in your Terminal application
    which will provide you instructions.

    If you have built the GUI, `dogecoin-qt` will launch it. Initial run will be a little slow.
    This is expected, and the case whether you build from source or use an `.app` bundle.
    EOS
  end
end
