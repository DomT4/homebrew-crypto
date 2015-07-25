class Ricochet < Formula
  desc "Anonymous peer-to-peer instant messaging"
  homepage "https://ricochet.im"
  url "https://github.com/ricochet-im/ricochet/archive/v1.1.0.tar.gz"
  sha256 "ab372c46a274825aa51ecc416966bee44fd69088fbc4b9f68fff46967a1becd9"
  head "https://github.com/ricochet-im/ricochet.git"

  depends_on "pkg-config" => :build
  depends_on "qt5"
  depends_on "openssl"
  depends_on "protobuf"
  depends_on "libevent" # For Tor

  # It kind of sucks at picking up Tor from the PATH, so vendor it for now.
  # FIX THIS
  resource "tor" do
    url "https://dist.torproject.org/tor-0.2.6.10.tar.gz"
    mirror "https://tor.eff.org/dist/tor-0.2.6.10.tar.gz"
    sha256 "0542c0efe43b86619337862fa7eb02c7a74cb23a79d587090628a5f0f1224b8d"
  end

  def install
    openssl = Formula["openssl"].opt_prefix

    system "qmake", "-config", "release", "OPENSSLDIR=#{openssl}",
                    "INCLUDEPATH+=#{openssl}/include", "LIBS+=-L#{openssl}/lib"
    system "make"
    libexec.install "Ricochet.app"

    resource("tor").stage do
      args = %W[
        --disable-dependency-tracking
        --disable-silent-rules
        --prefix=#{libexec}/Ricochet.app/Contents/Resources/Tor
        --sysconfdir=#{libexec}/Ricochet.app/Contents/Resources/Tor/unused
        --with-openssl-dir=#{openssl}
      ]

      system "./configure", *args
      system "make", "install"
      (libexec/"Ricochet.app/Contents/MacOS").install_symlink Dir[libexec/"Ricochet.app/Contents/Resources/Tor/bin/*"]
    end
  end

  def caveats; <<-EOS.undent
    Configuration files will be automatically generated upon first run.

    You may wish to backup #{libexec}/config.ricochet to somewhere that
    will persist across updates such as #{var}/ricochet.
  EOS
  end
end
