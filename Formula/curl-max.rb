class CurlMax < Formula
  desc "Feature-maximised version of cURL"
  homepage "https://curl.se"
  url "https://curl.se/download/curl-7.87.0.tar.bz2"
  mirror "https://github.com/curl/curl/releases/download/curl-7_84_0/curl-7.87.0.tar.bz2"
  sha256 "5d6e128761b7110946d1276aff6f0f266f2b726f5e619f7e0a057a474155f307"
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
  depends_on "zstd"

  # Needed for nghttp2
  resource "libevent" do
    url "https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz"
    sha256 "92e6de1be9ec176428fd2367677e61ceffc2ee1cb119035037a27d346b0403bb"
  end

  resource "nghttp2" do
    url "https://github.com/nghttp2/nghttp2/releases/download/v1.51.0/nghttp2-1.51.0.tar.xz"
    sha256 "66aa76d97c143f42295405a31413e5e7d157968dad9f957bb4b015b598882e6b"

    unless OS.mac?
      patch do
        # Fix: shrpx_api_downstream_connection.cc:57:3: error: array must be initialized with a brace-enclosed initializer
        url "https://gist.githubusercontent.com/iMichka/5dda45fbad3e70f52a6b4e7dfd382969/raw/19797e17926922bdd1ef21a47e162d8be8e2ca65/nghttp2?full_index=1"
        sha256 "0759d448d4b419911c12fa7d5cbf1df2d6d41835c9077bf3accf9eac58f24f12"
      end
    end
  end

  # Not in use yet but working towards it; want to ensure keeps building successfully.
  resource "nghttp3" do
    url "https://github.com/ngtcp2/nghttp3/releases/download/v0.8.0/nghttp3-0.8.0.tar.xz"
    sha256 "360dff3a914136a3394cd4fe52cb2c7df2528ddbbd8a61231538bf46ab74b2d7"
  end

  # Regular version from brew still on openssl@1.1; need to vendor to use openssl@3 here.
  resource "openldap" do
    url "https://www.openldap.org/software/download/OpenLDAP/openldap-release/openldap-2.6.3.tgz"
    sha256 "d2a2a1d71df3d77396b1c16ad7502e674df446e06072b0e5a4e941c3d06c0d46"

    # Fix -flat_namespace being used on Big Sur and later.
    patch do
      url "https://raw.githubusercontent.com/Homebrew/formula-patches/03cf8088210822aa2c1ab544ed58ea04c897d9c4/libtool/configure-big_sur.diff"
      sha256 "35acd6aebc19843f1a2b3a63e880baceb0f5278ab1ace661e57a502d9d78c93c"
    end
  end

  resource "libssh2" do
    url "https://www.libssh2.org/download/libssh2-1.10.0.tar.gz"
    sha256 "2d64e90f3ded394b91d3a2e774ca203a4179f69aebee03003e5a6fa621e41d51"
  end

  resource "libxml2" do
    url "https://download.gnome.org/sources/libxml2/2.10/libxml2-2.10.3.tar.xz"
    sha256 "5d2cc3d78bec3dbe212a9d7fa629ada25a7da928af432c93060ff5c17ee28a9c"
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

    resource("openldap").stage do
      args = %W[
        --disable-dependency-tracking
        --prefix=#{vendor}
        --sysconfdir=#{vendor}/etc
        --localstatedir=#{vendor}/var
        --enable-accesslog
        --enable-auditlog
        --enable-bdb=no
        --enable-constraint
        --enable-dds
        --enable-deref
        --enable-dyngroup
        --enable-dynlist
        --enable-hdb=no
        --enable-memberof
        --enable-ppolicy
        --enable-proxycache
        --enable-refint
        --enable-retcode
        --enable-seqmod
        --enable-translucent
        --enable-unique
        --enable-valsort
        --without-systemd
      ]

      if OS.linux? || MacOS.version >= :ventura
        # Disable manpage generation, because it requires groff which has a huge
        # dependency tree on Linux and isn't included on macOS since Ventura.
        inreplace "Makefile.in" do |s|
          subdirs = s.get_make_var("SUBDIRS").split - ["doc"]
          s.change_make_var! "SUBDIRS", subdirs.join(" ")
        end
      end

      system "./configure", *args
      system "make", "install"
      (vendor/"var/run").mkpath

      chmod 0755, Dir[vendor/"etc/openldap/*"]
      chmod 0755, Dir[vendor/"etc/openldap/schema/*"]
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
