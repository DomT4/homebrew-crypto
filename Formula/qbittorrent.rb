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
    depends_on "automake" => :build
    depends_on "autoconf" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkg-config" => :build
  # Once migrated to qt5 upstream the qt requirement will package easier
  depends_on "qt" => "with-d-bus"
  depends_on "openssl"
  depends_on "libtorrent-rasterbar"
  depends_on "boost"
  depends_on :python

  # It wants the .dat version, so just deliver it in resource form. Like Pizza. Yum.
  resource "geoip" do
    url "http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz"
    sha1 "58817a3b6a2206c28cdcd00a87b5bc7bcb944820"
  end

  # Doesn't like OS X's native zlib, and won't accept appropriate ENV flags.
  resource "zlib" do
    url "http://zlib.net/zlib-1.2.8.tar.gz"
    sha1 "a4d316c404ff54ca545ea71a27af7dbc29817088"
  end

  def install
    resource("geoip").stage do
      (buildpath/"src"/"geoip").install resource("geoip")
    end

    resource("zlib").stage do
      system "./configure", "--prefix=#{buildpath}/zlib", "--static"
      system "make", "install"
      ENV.append_path "PKG_CONFIG_PATH", "#{buildpath}/zlib/lib/pkgconfig"
    end

    # Never use the system OpenSSL. It is depreciated and insecure.
    inreplace "macxconf.pri" do |s|
      s.gsub! "/usr/include/openssl /usr/include /opt/local/include/boost /opt/local/include",
              "/usr/local/opt/openssl/include/openssl /usr/local/include/boost /usr/local/include"
      s.gsub! "-L/opt/local/lib", "-L/usr/local/opt/openssl/lib -L/usr/local/opt/boost/lib -L/usr/local/lib"
    end

    args = [ "--prefix=#{prefix}",
             "--with-geoip-database-embedded"]

    args << "--disable-silent-rules" if build.head?

    system "./bootstrap.sh" if build.head?
    system "./configure", *args
    system "make", "-j#{ENV.make_jobs}"

    # Install the app bundle into Homebrew's prefix
    prefix.install "src/qBittorrent.app"
  end
end
