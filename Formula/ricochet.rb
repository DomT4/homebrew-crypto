class Ricochet < Formula
  desc "Anonymous peer-to-peer instant messaging"
  homepage "https://ricochet.im"
  url "https://github.com/ricochet-im/ricochet/releases/download/v1.1.2/ricochet-1.1.2-src.tar.bz2"
  sha256 "97c78d088892e84c95a3e3a4a982883d8e44028848a513a5d7e0231d36325cc3"
  revision 1

  head "https://github.com/ricochet-im/ricochet.git"

  depends_on "pkg-config" => :build
  depends_on "qt5"
  depends_on "openssl"
  depends_on "protobuf"
  depends_on "libevent" # For Tor

  resource "tor" do
    url "https://dist.torproject.org/tor-0.2.8.9.tar.gz"
    mirror "https://tor.eff.org/dist/tor-0.2.8.9.tar.gz"
    sha256 "3f5c273bb887be4aff11f4d99b9e2e52d293b81ff4f6302b730161ff16dc5316"
  end

  def install
    (var/"ricochet").mkpath
    openssl = Formula["openssl"].opt_prefix

    system "qmake", "-config", "release", "OPENSSLDIR=#{openssl}",
                    "INCLUDEPATH+=#{openssl}/include", "LIBS+=-L#{openssl}/lib"
    system "make"
    libexec.install "Ricochet.app"

    resource("tor").stage do
      args = %W[
        --disable-dependency-tracking
        --disable-silent-rules
        --prefix=#{libexec}/Ricochet.app/Contents/Resources/tor
        --sysconfdir=#{libexec}/Ricochet.app/Contents/Resources/tor/unused
        --with-openssl-dir=#{openssl}
      ]

      system "./configure", *args
      system "make", "install"
      (libexec/"Ricochet.app/Contents/MacOS").install_symlink Dir[libexec/"Ricochet.app/Contents/Resources/tor/bin/*"]
    end
  end

  def caveats; <<-EOS.undent
    Configuration files will be automatically generated upon first run.

    You may wish to backup #{opt_libexec}/config.ricochet to somewhere that
    will persist across updates such as #{var}/ricochet.
  EOS
  end
end
