class ParcimonieSh < Formula
  desc "Refresh your GnuPG keyring discreetly"
  homepage "https://github.com/EtiennePerot/parcimonie.sh"
  url "https://github.com/EtiennePerot/parcimonie.sh.git",
      :revision => "5aa21efa3f5f20eb02a44a9681ec91bf2a380628"
  version "0.0.0.4" # Fake version to allow easier updates.
  version_scheme 1

  head "https://github.com/EtiennePerot/parcimonie.sh.git"

  depends_on :gpg
  depends_on "torsocks"
  depends_on "tor"

  def install
    inreplace "parcimonie.sh" do |s|
      s.gsub! "${TORSOCKS_BINARY:-torsocks}", "${TORSOCKS_BINARY:-#{Formula["torsocks"].opt_bin}/torsocks}"
      s.gsub! "${GNUPG_BINARY:-}", "${GNUPG_BINARY:-#{which("gpg")}}"
    end

    (var/"parcimonie").mkpath
    bin.install "parcimonie.sh" => "parcimonie"
  end

  def caveats; <<-EOS.undent
    Tor must be running for parcimonie to work.

    Note if using GnuPG 2.1.x there are some potential issues:
      https://github.com/EtiennePerot/parcimonie.sh/issues/15
  EOS
  end

  plist_options :manual => "parcimonie"

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>RunAtLoad</key>
        <true/>
        <key>KeepAlive</key>
        <true/>
        <key>ProgramArguments</key>
        <array>
            <string>/bin/sh</string>
            <string>-c</string>
            <string>#{opt_bin}/parcimonie</string>
        </array>
        <key>StandardErrorPath</key>
        <string>#{var}/parcimonie/keyupdate.err</string>
        <key>StandardOutPath</key>
        <string>#{var}/parcimonie/keyupdate.out</string>
      </dict>
    </plist>
    EOS
  end
end
