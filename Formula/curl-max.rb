class CurlMax < Formula
  desc "Feature-maximised version of cURL, using OpenSSL 1.1"
  homepage "https://curl.haxx.se/"
  url "https://curl.haxx.se/download/curl-7.63.0.tar.bz2"
  mirror "http://curl.mirror.anstey.ca/curl-7.63.0.tar.bz2"
  sha256 "9bab7ed4ecff77020a312d84cc5fb7eb02d58419d218f267477a724a17fd8dd8"

  bottle do
    root_url "https://dl.bintray.com/domt4/crypto-bottles"
    sha256 "c269889e2a71f9bc070dcf134b9658788065d5bb81b5962f89c0ff77b1c7d63c" => :mojave
  end

  keg_only :provided_by_macos

  depends_on "pkg-config" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "cunit" => :build
  depends_on "openssl@1.1"
  depends_on "c-ares"
  depends_on "libev"
  depends_on "jansson"
  depends_on "boost"
  depends_on "libidn2"
  depends_on "libmetalink"

  # Needed for nghttp2
  resource "libevent" do
    url "https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz"
    sha256 "965cc5a8bb46ce4199a47e9b2c9e1cae3b137e8356ffdad6d94d3b9069b71dc2"
  end

  resource "nghttp2" do
    url "https://github.com/nghttp2/nghttp2/releases/download/v1.35.1/nghttp2-1.35.1.tar.xz"
    sha256 "9b7f5b09c3ca40a46118240bf476a5babf4bd93a1e4fde2337c308c4c5c3263a"
  end

  resource "libssh2" do
    url "https://libssh2.org/download/libssh2-1.8.0.tar.gz"
    sha256 "39f34e2f6835f4b992cafe8625073a88e5a28ba78f83e8099610a7b3af4676d4"
  end

  resource "libxml2" do
    url "http://xmlsoft.org/sources/libxml2-2.9.8.tar.gz"
    mirror "https://ftp.osuosl.org/pub/blfs/conglomeration/libxml2/libxml2-2.9.8.tar.gz"
    sha256 "0b74e51595654f958148759cfef0993114ddccccbb6f31aee018f3558e8e2732"
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
