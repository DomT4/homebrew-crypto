class CurlMax < Formula
  desc "Feature-maximised version of cURL"
  homepage "https://curl.se"
  url "https://curl.se/download/curl-8.11.1.tar.bz2"
  mirror "https://github.com/curl/curl/releases/download/curl-8_11_1/curl-8.11.1.tar.bz2"
  sha256 "e9773ad1dfa21aedbfe8e1ef24c9478fa780b1b3d4f763c98dd04629b5e43485"
  license "curl"

  keg_only :provided_by_macos

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "cunit" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "boost"
  depends_on "brotli"
  depends_on "c-ares"
  depends_on "jansson"
  depends_on "jemalloc"
  depends_on "libev"
  depends_on "libidn2"
  depends_on "libpsl"
  depends_on "openssl@3"
  depends_on "openldap"
  depends_on "zstd"

  # Needed for nghttp2
  resource "libevent" do
    url "https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz"
    sha256 "92e6de1be9ec176428fd2367677e61ceffc2ee1cb119035037a27d346b0403bb"
  end

  resource "nghttp2" do
    url "https://github.com/nghttp2/nghttp2/releases/download/v1.64.0/nghttp2-1.64.0.tar.xz"
    sha256 "88bb94c9e4fd1c499967f83dece36a78122af7d5fb40da2019c56b9ccc6eb9dd"
  end

  resource "ngtcp2" do
    url "https://github.com/ngtcp2/ngtcp2/releases/download/v1.10.0/ngtcp2-1.10.0.tar.xz"
    sha256 "4f8dc1d61957205d01c3d6aa6f1c96c7b2bac1feea71fdaf972d86db5f6465df"
  end

  resource "nghttp3" do
    url "https://github.com/ngtcp2/nghttp3/releases/download/v1.7.0/nghttp3-1.7.0.tar.xz"
    sha256 "b4eb6bceb99293d9a9df2031c1aad166af3d57b3e33655aca0699397b6f0d751"
  end

  resource "libssh2" do
    url "https://libssh2.org/download/libssh2-1.11.1.tar.xz"
    sha256 "9954cb54c4f548198a7cbebad248bdc87dd64bd26185708a294b2b50771e3769"
  end

  resource "libxml2" do
    url "https://download.gnome.org/sources/libxml2/2.13/libxml2-2.13.0.tar.xz"
    sha256 "d5a2f36bea96e1fb8297c6046fb02016c152d81ed58e65f3d20477de85291bc9"
  end

  def install
    vendor = libexec/"vendor"
    ENV.prepend_path "PKG_CONFIG_PATH", Formula["openssl@3"].opt_lib/"pkgconfig"
    ENV.prepend_path "PKG_CONFIG_PATH", vendor/"lib/pkgconfig"
    ENV.prepend_path "PATH", vendor/"bin"

    resource("libxml2").stage do
      system "./configure", "--disable-dependency-tracking",
                            "--prefix=#{vendor}",
                            "--without-python",
                            "--without-lzma"
      system "make", "install"
    end

    # This isn't actually being used for anything yet but going to keep
    # building it so that I know it DOES build when we need it.
    resource("ngtcp2").stage do
      system "./configure", "--disable-dependency-tracking",
                            "--prefix=#{vendor}"
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
      # fix for clang not following C++14 behaviour
      # https://github.com/macports/macports-ports/commit/54d83cca9fc0f2ed6d3f873282b6dd3198635891
      inreplace "src/shrpx_client_handler.cc", "return dconn;", "return std::move(dconn);"

      args = %W[
        --prefix=#{vendor}
        --disable-silent-rules
        --disable-examples
        --without-systemd
        --disable-hpack-tools
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

    resource("nghttp3").stage do
      system "./configure", "--prefix=#{vendor}", "--disable-silent-rules"
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
                            "--with-libz",
                            "--with-libssl-prefix=#{Formula["openssl@3"].opt_prefix}"
      system "make", "install"
    end

    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
      --with-default-ssl-backend=openssl
      --with-ssl=#{Formula["openssl@3"].opt_prefix}
      --with-ca-bundle=#{etc}/openssl@3/cert.pem
      --with-ca-path=#{etc}/openssl@3/certs
      --enable-ares=#{Formula["c-ares"].opt_prefix}
      --with-brotli
      --with-gssapi
      --with-libidn2
      --with-libpsl
      --with-libssh2
      --enable-ldap
      --with-nghttp3
      --with-openssl-quic
    ]

    system "./configure", *args
    system "make", "install"
    system "make", "install", "-C", "scripts"
    libexec.install "scripts/mk-ca-bundle.pl"
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
    system ENV.cc, "test.c", "-L#{libexec}/vendor/lib",
                   "-I#{libexec}/vendor/include", "-levent", "-o", "test"
    system "./test"

    (testpath/"test2.c").write <<~EOS
      #include <libssh2.h>

      int main(void)
      {
      libssh2_exit();
      return 0;
      }
    EOS

    system ENV.cc, "test2.c", "-L#{libexec}/vendor/lib",
                   "-I#{libexec}/vendor/include", "-lssh2", "-o", "test2"
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
