class Ricochet < Formula
  desc "Anonymous peer-to-peer instant messaging"
  homepage "https://ricochet.im"
  url "https://github.com/ricochet-im/ricochet/archive/v1.1.1.tar.gz"
  sha256 "baa67151ca1ed4ce1fea0367b260c7761f3d69eb9efd801200b627fafe8be978"
  revision 1

  head "https://github.com/ricochet-im/ricochet.git"

  depends_on "pkg-config" => :build
  depends_on "qt5"
  depends_on "openssl"
  depends_on "protobuf"
  depends_on "libevent" # For Tor

  resource "tor" do
    url "https://dist.torproject.org/tor-0.2.7.6.tar.gz"
    mirror "https://tor.eff.org/dist/tor-0.2.7.6.tar.gz"
    sha256 "493a8679f904503048114aca6467faef56861206bab8283d858f37141d95105d"
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

    You may wish to backup #{libexec}/config.ricochet to somewhere that
    will persist across updates such as #{var}/ricochet.
  EOS
  end
end
