class CaBundle < Formula
  desc "Generates Mozilla CA bundles for Homebrew's OpenSSL"
  homepage "https://github.com/bagder/curl"
  url "https://raw.githubusercontent.com/bagder/curl/143acd6222319e9cf2e355fdc27c07e4e955e403/lib/mk-ca-bundle.pl"
  version "032015"
  sha256 "7f28e9e99846b2001b05e682bbdec7c2a270dfa9e32451c17462e9f1b01ea277"
  revision 1

  depends_on "openssl"
  depends_on "curl" => :recommended

  def install
    libexec.install "mk-ca-bundle.pl"

    (bin+"mk-ca-bundle").write <<-EOS.undent
      #!/usr/bin/env bash
      export PATH=#{Formula["openssl"].opt_prefix}/bin:$PATH
      export PATH=#{Formula["curl"].opt_prefix}/bin:$PATH

      exec perl #{libexec}/mk-ca-bundle.pl "$@"
    EOS
    chmod 0755, bin+"mk-ca-bundle"
  end

  def post_install
    # hopenssl = Homebrew's OpenSSL
    hopenssl = "#{Formula["openssl"].opt_prefix}/bin/openssl"

    cd libexec do
      system bin/"mk-ca-bundle"
      system "#{hopenssl} x509 -in ca-bundle.crt -out homebrewed-ca-bundle.pem -outform PEM"

      (etc+"openssl/certs").install "homebrewed-ca-bundle.pem"
      rm "certdata.txt"
    end

    system "#{Formula["openssl"].opt_prefix}/bin/c_rehash"
  end

  def caveats; <<-EOS.undent
    We all know the CA system is broken to hell and back, so obviously, use all cert scripts
    with an enormous pinch of salt.

    That said - If you're using Firefox or `cURL` you've likely already got these
    certs on your system and are actively using them.

    For further complaints about the CA system, see:
      https://en.wikipedia.org/wiki/Certificate_authority#CA_compromise
      https://www.eff.org/deeplinks/2011/12/2011-review-ever-clearer-vulnerabilities-certificate-authority-system
      http://www.scmagazine.com/the-flawed-certificate-authority-system/article/212015/
    EOS
  end

  test do
    assert File.exist?(bin+"mk-ca-bundle")
  end
end
