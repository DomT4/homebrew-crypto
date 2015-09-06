class Bitcoind < Formula
  desc "Innovative decentralized, peer-to-peer payment network"
  homepage "https://bitcoin.org/en/"
  url "https://github.com/bitcoin/bitcoin/archive/v0.11.0.tar.gz"
  sha256 "2bcd61a4c288e5cc5d7fbe724606c610a20037332b06f7a9e99c1153eef73aef"
  head "https://github.com/bitcoin/bitcoin.git"

  option "with-gui", "Build with the GUI enabled in addition to the Daemon/CLI"

  depends_on "pkg-config" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on :xcode => :build
  depends_on "openssl"
  depends_on "boost"
  depends_on "berkeley-db4"
  depends_on "miniupnpc" => :recommended

  if build.with? "gui"
    depends_on "protobuf"
    depends_on "qt5"
    depends_on "qrencode"
    depends_on "gettext" => :recommended
  end

  def install
    args = ["--prefix=#{libexec}", "--disable-dependency-tracking"]

    if build.with? "gui"
      args << "--with-qrencode"
      args << "--with-gui=qt5"
    end

    args << "--with-miniupnpc" if build.with? "miniupnpc"

    system "./autogen.sh"
    system "./configure", *args

    system "make"
    system "make", "check"
    system "make", "install"
    bin.write_exec_script Dir["#{libexec}/bin/*"]
  end

  plist_options :manual => "bitcoind -daemon"

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>KeepAlive</key>
        <true/>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{opt_bin}/bitcoind</string>
          <string>-daemon</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
      </dict>
    </plist>
    EOS
  end

  def caveats; <<-EOS.undent
    Bitcoind will need to set up bitcoin.conf on first-run. You can manually do this with:

      echo -e "rpcuser=bitcoinrpc\\nrpcpassword=$(xxd -l 16 -p /dev/urandom)" > ~/Library/Application\\ Support/Bitcoin/bitcoin.conf
      chmod 600 ~/Library/Application\\ Support/Bitcoin/bitcoin.conf

    Or automatically by running 'bitcoind' in your Terminal application, which will provide you instructions.
    EOS
  end
end
