class Bopenssh < Formula
  homepage "http://www.openssh.com/"
  url "http://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-6.8p1.tar.gz"
  mirror "http://ftp.eu.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-6.8p1.tar.gz"
  version "6.8p1"
  sha256 "3ff64ce73ee124480b5bf767b9830d7d3c03bbcb6abe716b78f0192c37ce160e"

  depends_on "pkg-config" => :build
  depends_on "libressl" => :recommended
  depends_on "openssl" => :optional
  depends_on "copenssl" => :optional
  depends_on "ldns" => :optional

  patch do
    url "https://gist.githubusercontent.com/jacknagel/e4d68a979dca7f968bdb/raw/f07f00f9d5e4eafcba42cc0be44a47b6e1a8dd2a/sandbox.diff"
    sha256 "82c287053eed12ce064f0b180eac2ae995a2b97c6cc38ad1bdd7626016204205"
  end

  # Patch for SSH tunnelling issues caused by launchd changes on Yosemite
  patch do
    url "https://trac.macports.org/export/135165/trunk/dports/net/openssh/files/launchd.patch"
    sha1 "02e76c153d2d51bb0b4b0e51dd7b302469bd24deac487f7cca4ee536928bceef"
  end

  def install
    ENV.append "CPPFLAGS", "-D__APPLE_SANDBOX_NAMED_EXTERNAL__"

    args = %W[
      --with-libedit
      --with-pam
      --with-kerberos5
      --prefix=#{prefix}
      --sysconfdir=#{etc}/ssh
    ]

    args << "--with-ldns" if build.with? "ldns"

    if build.with? "openssl"
      args << "--with-ssl-dir=#{Formula["openssl"].opt_prefix}"
    elsif build.with? "copenssl"
      args << "--with-ssl-dir=#{Formula["copenssl"].opt_prefix}"
    else
      args << "--with-ssl-dir=#{Formula["libressl"].opt_prefix}"
    end

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
