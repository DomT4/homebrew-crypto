class Bopenssh < Formula
  homepage "http://www.openssh.com/"
  url "http://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-6.7p1.tar.gz"
  mirror "http://ftp.eu.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-6.7p1.tar.gz"
  version "6.7p1"
  sha256 "b2f8394eae858dabbdef7dac10b99aec00c95462753e80342e530bbb6f725507"
  revision 6

  option "with-ldns", "build with ldns"

  depends_on "pkg-config" => :build
  depends_on "libressl" => :recommended
  depends_on "openssl" => :optional
  depends_on "copenssl" => :optional
  depends_on "ldns" => :optional

  patch do
    url "https://gist.githubusercontent.com/sigkate/fca7ee9fe1cdbe77ba03/raw/6894261e7838d81c76ef4b329e77e80d5ad25afc/patch-openssl-darwin-sandbox.diff"
    sha1 "332a1831bad9f2ae0f507f7ea0aecc093829b1c4"
  end

  # Patch for SSH tunnelling issues caused by launchd changes on Yosemite
  patch do
    url "https://trac.macports.org/export/131258/trunk/dports/net/openssh/files/launchd.patch"
    sha1 "e35731b6d0e999fb1d58362cda2574c0d1efed78"
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
