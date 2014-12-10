require "formula"

# This is a completely made up requirement to stop people installing
# stable for now. This is required because 3.1.1 won't build on OS X.
# This should be safe to remove when the current 3.2.0 branch is stable
# This is because the stable 3.1.11 release has no mechanism for finding
# libboost successfully on OS X, for some reason. The two configure flags
# seem to be ignored even when explicitly invoked. The stable build also
# makes calls to libtorrent that are declared fatal errors on OS X.
# This should be easy enough to build statically rather than dynamically
# though so creating an app bundle for 3.1.11 upwards is relatively doable.
require 'requirement'

class Lateststablereleaseisdead < Requirement
  fatal true

  def initialize(tags)
    @version = MacOS::Version.from_symbol(tags.first)
    super
  end

  satisfy { MacOS.version <= @version }

  def message
    <<-EOS.undent
      3.1.11 fails to build on OS X via dynamic linking.
      Please build HEAD instead for now.
      HEAD will land you on the latest 3.2.0 Alpha from the Git.
    EOS
  end
end

class Qbittorrent < Formula
  homepage "http://www.qbittorrent.org/"

  stable do
    url "https://github.com/qbittorrent/qBittorrent/archive/release-3.1.11.tar.gz"
    sha1 "cda0a01e158dc3b91b66e05c47232255c9663763"

    # Stable is dead. Force HEAD for now - That actually builds fine.
    depends_on Lateststablereleaseisdead => :tiger
  end

  head do
    url "https://github.com/qbittorrent/qBittorrent.git"
  end

  depends_on "pkg-config" => :build
  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "libtool" => :build
  depends_on "qt" => "with-d-bus"
  depends_on "openssl"
  depends_on "libtorrent-rasterbar"
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

    # Never use the system OpenSSL. It is depreciated and insecure.
    inreplace "macxconf.pri" do |s|
      s.gsub! "/usr/include/openssl /usr/include /opt/local/include/boost /opt/local/include",
              "/usr/local/opt/openssl/include/openssl /usr/local/opt/boost/include/boost /usr/local/include"
      s.gsub! "-L/opt/local/lib", "-L/usr/local/opt/openssl/lib -L/usr/local/opt/boost/lib -L/usr/local/lib"
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
