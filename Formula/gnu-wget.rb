class GnuWget < Formula
  desc "Internet file retriever built against LibreSSL"
  homepage "https://www.gnu.org/software/wget/"
  url "https://ftp.gnu.org/gnu/wget/wget-1.21.2.tar.gz"
  sha256 "e6d4c76be82c676dd7e8c61a29b2ac8510ae108a810b5d1d18fc9a1d2c9a2497"
  license "GPL-3.0-or-later"

  head do
    url "https://git.savannah.gnu.org/git/wget.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "xz" => :build
    depends_on "gettext"
  end

  option "with-default-names", "Do not prepend 'l' to the binary"

  depends_on "pkg-config" => :build
  depends_on "libressl"
  depends_on "libidn2" => :recommended
  depends_on "gpgme" => :optional
  depends_on "libmetalink" => :optional
  depends_on "pcre" => :optional
  depends_on "pcre2" => :optional

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --with-ssl=openssl
      --with-libssl-prefix=#{Formula["libressl"].opt_prefix}
      --disable-debug
      --without-included-regex
    ]

    args << "--program-prefix=l" if build.without? "default-names"
    args << "--disable-pcre" if build.without? "pcre"
    args << "--disable-pcre2" if build.without? "pcre2"
    args << "--with-metalink" if build.with? "libmetalink"
    args << "--with-gpgme-prefix=#{Formula["gpgme"].opt_prefix}" if build.with? "gpgme"

    system "./bootstrap" if build.head?
    system "./configure", *args
    system "make", "install"

    if build.without? "default-names"
      mv info/"wget.info", info/"lwget.info"
      mv man1/"wget.1", man1/"lwget.1"
      rm_rf share/"locale" # Not worth renaming every single file here.
    end
  end

  def caveats
    return if build.with? "default-names"

    <<~EOS
      The binary is prepended with a 'l' so this can be used
      alongside Homebrew's `wget` without conflict.
    EOS
  end

  test do
    system bin/"lwget", "-O", "/dev/null", "https://duckduckgo.com"
  end
end
