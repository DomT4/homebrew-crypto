class CurlMax < Formula
  desc "Feature-maximised version of cURL, using OpenSSL 1.1"
  homepage "https://curl.haxx.se/"
  url "https://curl.haxx.se/download/curl-7.64.1.tar.bz2"
  sha256 "4cc7c738b35250d0680f29e93e0820c4cb40035f43514ea3ec8d60322d41a45d"

  bottle do
    root_url "https://dl.bintray.com/domt4/crypto-bottles"
    sha256 "62715b93c15d98ed5a7417d4badc39067d439f1239954ea4845dd1200c32ac81" => :mojave
  end

  keg_only :provided_by_macos

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "cunit" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "boost"
  depends_on "c-ares"
  depends_on "jansson"
  depends_on "libev"
  depends_on "libidn2"
  depends_on "libmetalink"
  depends_on "openssl@1.1"

  # Needed for nghttp2
  resource "libevent" do
    url "https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz"
    sha256 "965cc5a8bb46ce4199a47e9b2c9e1cae3b137e8356ffdad6d94d3b9069b71dc2"
  end

  resource "nghttp2" do
    url "https://github.com/nghttp2/nghttp2/releases/download/v1.37.0/nghttp2-1.37.0.tar.xz"
    sha256 "aa090b164b17f4b91fe32310a1c0edf3e97e02cd9d1524eef42d60dd1e8d47b7"
  end

  resource "libssh2" do
    url "https://libssh2.org/download/libssh2-1.8.2.tar.gz"
    sha256 "088307d9f6b6c4b8c13f34602e8ff65d21c2dc4d55284dfe15d502c4ee190d67"
  end

  resource "libxml2" do
    url "http://xmlsoft.org/sources/libxml2-2.9.9.tar.gz"
    mirror "https://ftp.osuosl.org/pub/blfs/conglomeration/libxml2/libxml2-2.9.9.tar.gz"
    sha256 "94fb70890143e3c6549f265cee93ec064c80a84c42ad0f23e85ee1fd6540a871"
  end

  def install
    vendor = libexec/"vendor"
    ENV.prepend_path "PKG_CONFIG_PATH", Formula["openssl@1.1"].opt_lib/"pkgconfig"
    ENV.prepend_path "PKG_CONFIG_PATH", vendor/"lib/pkgconfig"
    ENV.prepend_path "PATH", vendor/"bin"

    resource("libxml2").stage do
      system "./configure", "--disable-dependency-tracking",
                            "--prefix=#{vendor}",
                            "--without-python",
                            "--without-lzma"
      system "make", "install"
    end

    resource("libevent").stage do
      system "./configure", "--disable-dependency-tracking",
                            "--disable-debug-mode",
                            "--prefix=#{vendor}"
      system "make"
      system "make", "install"
    end

    resource("nghttp2").stage do
      args = %W[
        --prefix=#{vendor}
        --disable-silent-rules
        --enable-app
        --with-boost=#{Formula["boost"].opt_prefix}
        --enable-asio-lib
        --disable-python-bindings
      ]
      # requires thread-local storage features only available in 10.11+
      args << "--disable-threads" if MacOS.version < :el_capitan

      system "./configure", *args
      system "make"
      system "make", "check"
      system "make", "install"
    end

    resource("libssh2").stage do
      system "./configure", "--prefix=#{vendor}",
                            "--disable-debug",
                            "--disable-dependency-tracking",
                            "--disable-silent-rules",
                            "--disable-examples-build",
                            "--with-openssl",
                            "--with-libz",
                            "--with-libssl-prefix=#{Formula["openssl@1.1"].opt_prefix}"
      system "make", "install"
    end

    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
      --with-libidn2
      --with-ssl=#{Formula["openssl@1.1"].opt_prefix}
      --with-ca-bundle=#{etc}/openssl@1.1/cert.pem
      --with-ca-path=#{etc}/openssl@1.1/certs
      --enable-ares=#{Formula["c-ares"].opt_prefix}
      --with-libssh2
      --without-librtmp
      --with-gssapi
      --with-libmetalink
    ]

    system "./configure", *args
    system "make", "install"
    libexec.install "lib/mk-ca-bundle.pl"

    # curl-config --libs outputs all libs, even private ones.
    # Is a known issue upstream but can cause problems when
    # third-parties try to link against curl. Can be fixed
    # with an inreplace until upstream find a happy solution.
    inreplace bin/"curl-config",
              "${CURLLIBDIR}-lcurl -lcares",
              "${CURLLIBDIR} -L#{vendor}/lib -lcurl -lcares"
  end

  test do
    # Test vendored libraries.
    (testpath/"test.c").write <<~EOS
      #include <event2/event.h>

      int main()
      {
        struct event_base *base;
        base = event_base_new();
        event_base_free(base);
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-L#{libexec}/vendor/lib", "-levent", "-o", "test"
    system "./test"

    (testpath/"test2.c").write <<~EOS
      #include <libssh2.h>

      int main(void)
      {
      libssh2_exit();
      return 0;
      }
    EOS

    system ENV.cc, "test2.c", "-L#{libexec}/vendor/lib", "-lssh2", "-o", "test2"
    system "./test2"

    (testpath/"test3.c").write <<~EOS
      #include <libxml/tree.h>

      int main()
      {
        xmlDocPtr doc = xmlNewDoc(BAD_CAST "1.0");
        xmlNodePtr root_node = xmlNewNode(NULL, BAD_CAST "root");
        xmlDocSetRootElement(doc, root_node);
        xmlFreeDoc(doc);
        return 0;
      }
    EOS
    args = shell_output("#{libexec}/vendor/bin/xml2-config --cflags --libs").split
    args += %w[test3.c -o test3]
    system ENV.cc, *args
    system "./test3"

    # Test vendored executables.
    system libexec/"vendor/bin/nghttp", "-nv", "https://nghttp2.org"

    # Test IDN support.
    ENV.delete("LC_CTYPE")
    ENV["LANG"] = "en_US.UTF-8"
    system bin/"curl", "-L", "www.räksmörgås.se", "-o", "index.html"
    assert_predicate testpath/"index.html", :exist?,
                     "Failed to download IDN example site!"
    assert_match "www.xn--rksmrgs-5wao1o.se", File.read("index.html")

    # Fetch the curl tarball and see that the checksum matches.
    # This requires a network connection, but so does Homebrew in general.
    filename = (testpath/"test.tar.gz")
    system bin/"curl", "-L", stable.url, "-o", filename
    filename.verify_checksum stable.checksum

    system libexec/"mk-ca-bundle.pl", "test.pem"
    assert_predicate testpath/"test.pem", :exist?, "Failed to generate PEM!"
    assert_predicate testpath/"certdata.txt", :exist?
  end
end
