require "formula"

class Qbittorrent < Formula
  homepage "http://www.qbittorrent.org/"

  stable do
    url "https://github.com/qbittorrent/qBittorrent/archive/release-3.1.11.tar.gz"
    sha1 "cda0a01e158dc3b91b66e05c47232255c9663763"

    # Till 3.20.x is released, qb needs no higher than 0.16.x, so resource it out for now.
    resource "libtorrent-rasterbar" do
      url "https://downloads.sourceforge.net/project/libtorrent/libtorrent/libtorrent-rasterbar-0.16.17.tar.gz"
      sha1 "e713b5dfc45194bfc50fa21096ab67c374ae3740"
    end
  end

  bottle do
    root_url "https://raw.githubusercontent.com/DomT4/LibreMirror/master/Homebrew/Tap_Bottles"
    sha1 "ecf183e8ccb929a77ef715d971238f2d5b7867ef" => :yosemite
  end

  head do
    url "https://github.com/qbittorrent/qBittorrent.git"

    # Make this a dep for all again once 3.20.x is stable.
    depends_on "libtorrent-rasterbar"
  end

  depends_on "pkg-config" => :build
  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "libtool" => :build
  depends_on "qt" => "with-d-bus"
  depends_on "openssl"
  depends_on "boost"
  depends_on :python

  # It wants the .dat version, so just deliver it in resource form. Like Pizza. Yum.
  # Ugh. Upstream use a dynamically changing link. I hate those.
  # Use Debian's versioned link for now. People trust Debian, and I trust Debian.
  resource "geoip" do
    url "https://mirrors.kernel.org/debian/pool/main/g/geoip/geoip_1.6.3.orig.tar.gz"
    sha1 "7561dcb5ba928a3f190426709063829093283c32"
  end

  # Doesn't like OS X's native zlib, and won't accept appropriate ENV flags.
  resource "zlib" do
    url "http://zlib.net/zlib-1.2.8.tar.gz"
    sha1 "a4d316c404ff54ca545ea71a27af7dbc29817088"
  end

  def install
    resource("geoip").stage do
      ENV["GEOIP_ARCH"] = "-arch x86_64"
      system "./bootstrap"
      mv "data/geoip.dat", buildpath/"src/geoip"
    end

    resource("zlib").stage do
      system "./configure", "--prefix=#{buildpath}/zlib", "--static"
      system "make", "install"
      ENV.append_path "PKG_CONFIG_PATH", "#{buildpath}/zlib/lib/pkgconfig"
    end

    if build.stable?
      resource("libtorrent-rasterbar").stage do
        system "./configure", "--prefix=#{libexec}/libtorrent-rasterbar", "--disable-debug",
                              "--disable-dependency-tracking", "--with-boost=#{Formula["boost"].opt_prefix}"
        system "make", "install"
        ENV.append_path "PKG_CONFIG_PATH", "#{libexec}/libtorrent-rasterbar/lib/pkgconfig"
      end
    end

    # Never use the system OpenSSL. It is depreciated and insecure.
    inreplace "macxconf.pri" do |s|
      s.gsub! "/usr/include/openssl /usr/include /opt/local/include/boost /opt/local/include",
              "#{Formula["openssl"].opt_prefix}/include/openssl #{Formula["boost"].opt_prefix}/include/boost /usr/local/include #{libexec}/libtorrent-rasterbar/include"
      s.gsub! "-L/opt/local/lib", "-L#{Formula["openssl"].opt_prefix}/lib -L#{Formula["boost"].opt_prefix}/lib -L/usr/local/lib -L#{libexec}/libtorrent-rasterbar/lib"
    end

    args = [ "--prefix=#{prefix}",
             "--with-geoip-database-embedded"]

    if build.head?
      args << "--disable-silent-rules"
      system "./bootstrap.sh"
    end

    if build.stable?
      inreplace "configure", "*.so", "*.dylib"
      args << "--with-libboost-inc=#{Formula["boost"].opt_prefix}/include/boost"
      args << "--with-libboost-lib=#{Formula["boost"].opt_prefix}/lib"
    end

    system "./configure", *args
    system "make", "-j#{ENV.make_jobs}"

    # Install the app bundle into Homebrew's prefix
    prefix.install "src/qBittorrent.app"
  end
end
