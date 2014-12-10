require "formula"

# NOTE: Configure will fail if using awk 20110810 from dupes.
# Upstream issue: https://savannah.gnu.org/bugs/index.php?37063

class GnuWget < Formula
  homepage "https://www.gnu.org/software/wget/"
  url "http://ftpmirror.gnu.org/wget/wget-1.16.1.tar.xz"
  mirror "https://ftp.gnu.org/gnu/wget/wget-1.16.1.tar.xz"
  sha1 "21cd7eee08ab5e5a14fccde22a7aec55b5fcd6fc"

  head do
    url "git://git.savannah.gnu.org/wget.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "gettext"
  end

  option "with-iri", "Enable iri support"
  option "with-debug", "Build with debug support"

  depends_on "libressl"
  depends_on "libidn" if build.with? "iri"

  # To remove the LibreSSL-unsupported RAND-egd option from wget
  # This patch originates from the OpenBSD team.
  patch :DATA

  def install
    if build.head?
      ln_s cached_download/".git", ".git"
      system "./bootstrap"
    end

    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --with-ssl=openssl
      --with-libssl-prefix=#{Formula["libressl"].opt_prefix}
    ]

    args << "--disable-debug" if build.without? "debug"
    args << "--disable-iri" if build.without? "iri"

    system "./configure", *args
    system "make", "install"
  end

  def caveats; <<-EOS.undent
    This wget exists as a test-bed for using LibreSSL for wget.
    If you wish to build wget with OpenSSL, as per usual, use the normal
    Homebrew one found with `brew install wget`.
    Once wget with LibreSSL is in Homebrew-core, this file will cease to exist.
    EOS
  end

  test do
    system "#{bin}/wget", "-O", "-", "https://duckduckgo.com"
  end
end

__END__

--- a/src/openssl.c Sat Apr 19 06:12:48 2014
+++ b/src/openssl.c Sat Apr 19 06:13:18 2014
@@ -86,9 +86,11 @@ init_prng (void)
   if (RAND_status ())
     return;
 
+#ifdef HAVE_SSL_RAND_EGD
   /* Get random data from EGD if opt.egd_file was used.  */
   if (opt.egd_file && *opt.egd_file)
     RAND_egd (opt.egd_file);
+#endif
 
   if (RAND_status ())
     return;
