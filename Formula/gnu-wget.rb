# NOTE: Configure will fail if using awk 20110810 from dupes.
# Upstream issue: https://savannah.gnu.org/bugs/index.php?37063
class GnuWget < Formula
  desc "Internet file retriever built against LibreSSL"
  homepage "https://www.gnu.org/software/wget/"
  url "http://ftpmirror.gnu.org/wget/wget-1.16.3.tar.xz"
  mirror "https://ftp.gnu.org/gnu/wget/wget-1.16.3.tar.xz"
  sha256 "67f7b7b0f5c14db633e3b18f53172786c001e153d545cfc85d82759c5c2ffb37"
  revision 4

  head do
    url "git://git.savannah.gnu.org/wget.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "xz" => :build
    depends_on "gettext"
  end

  option "with-default-names", "Do not prepend 'l' to the binary"
  option "with-debug", "Build with debug support"

  depends_on "libressl"
  depends_on "libidn" => :optional
  depends_on "pcre" => :optional

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --with-ssl=openssl
      --with-libssl-prefix=#{Formula["libressl"].opt_prefix}
    ]

    args << "--program-prefix=l" if build.without? "default-names"
    args << "--disable-debug" if build.without? "debug"
    args << "--disable-iri" if build.without? "libidn"
    args << "--disable-pcre" if build.without? "pcre"

    system "./bootstrap" if build.head?
    system "./configure", *args
    system "make", "install"
    rm_rf share/"info"

    mv "#{man1}/wget.1", "#{man1}/lwget.1" if build.without? "default-names"
  end

  def caveats; <<-EOS.undent
    The binary is prepended with a 'l' so this can be used
    alongside Homebrew/Homebrew's wget without conflict.
    EOS
  end

  test do
    system bin/"lwget", "-O", "-", "https://duckduckgo.com"
  end
end
