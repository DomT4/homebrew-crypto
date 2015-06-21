class HasGnuPG < Requirement
  fatal true
  default_formula "gnupg"
  satisfy { which("gpg") || which("gpg2") }
end

class ParcimonieSh < Formula
  desc "Refresh your GnuPG keyring discreetly"
  homepage "https://github.com/EtiennePerot/parcimonie.sh"
  url "https://github.com/EtiennePerot/parcimonie.sh.git", :revision => "d7d83f0da29d5880da6e8f060fa5e52738e8ae17"
  version "23032015"
  head "https://github.com/EtiennePerot/parcimonie.sh.git"

  depends_on HasGnuPG
  depends_on "gnupg" => :recommended
  depends_on "gnupg2" => :optional
  depends_on "homebrew/versions/gnupg21" => :optional
  depends_on "torsocks" => :recommended
  depends_on "tor" => :optional

  def install
    inreplace "parcimonie.sh" do |s|
      s.gsub! "${TORSOCKS_BINARY:-torsocks}", "${TORSOCKS_BINARY:-#{Formula["torsocks"].opt_bin}/torsocks}"
      s.gsub! "${TMP_PREFIX:-/tmp/parcimonie}", "${TMP_PREFIX:-#{var}/parcimonie}"
    end

    if build.with? "gnupg21"
      inreplace "parcimonie.sh", "${GNUPG_BINARY:-gpg}", "${GNUPG_BINARY:-#{Formula["gnupg21"].opt_bin}/gpg2}"
    elsif build.with? "gnupg2"
      inreplace "parcimonie.sh", "${GNUPG_BINARY:-gpg}", "${GNUPG_BINARY:-#{Formula["gnupg2"].opt_bin}/gpg2}"
    else
      inreplace "parcimonie.sh", "${GNUPG_BINARY:-gpg}", "${GNUPG_BINARY:-#{Formula["gnupg"].opt_bin}/gpg}"
    end

    mkdir_p var/"parcimonie"
    bin.install "parcimonie.sh" => "parcimonie"
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

  def caveats; <<-EOS.undent
    Tor MUST be running for parcimonie to work.
  EOS
  end
end
