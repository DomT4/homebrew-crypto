class Ricochet < Formula
  desc "Anonymous peer-to-peer instant messaging"
  homepage "https://ricochet.im"
  url "https://ricochet.im/releases/1.1.4/ricochet-1.1.4-src.tar.bz2"
  sha256 "f5f32caa3480def1de5c93010c6bf5f5789ddcba34bf09fc0feab67696d0c374"
  revision 13

  head "https://github.com/ricochet-im/ricochet.git"

  depends_on "pkg-config" => :build
  depends_on "qt"
  depends_on "openssl"
  depends_on "protobuf"
  depends_on "libevent" # For Tor

  resource "tor" do
    url "https://www.torproject.org/dist/tor-0.3.3.6.tar.gz"
    mirror "https://tor.eff.org/dist/tor-0.3.3.6.tar.gz"
    sha256 "99bc59f6dbf395894de12f3a83b3251a82dfd93dc7f6d3afcbbd80f6111433b7"
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

  test do
    output = shell_output("#{libexec}/Ricochet.app/Contents/MacOS/tor --version")
    assert_match resource("tor").version.to_s, output
  end
end
