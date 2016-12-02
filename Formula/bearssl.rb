class Bearssl < Formula
  desc "Implementation of the SSL/TLS protocol written in C"
  homepage "https://bearssl.org/index.html"
  url "https://bearssl.org/bearssl-0.1.tar.gz"
  sha256 "be33f84a6304dacffdfa99c5539cfde5681153a7e916a1b0cf2c5c2a4f623bbe"

  head do
    url "https://www.bearssl.org/git/BearSSL", :using => :git

    depends_on "doxygen" => [:build, :optional]
    depends_on "graphviz" => :build if build.with? "doxygen"
  end

  def install
    system "make"

    if build.head? && build.with?("doxygen")
      system "doxygen"
      doc.install Dir["apidoc/html/*"]
    end

    # No "make install".
    bin.install "brssl"
    (include/"bearssl").install Dir["inc/*.h"]
    lib.install "libbearssl.a"
  end

  def caveats; <<-EOS.undent
    Quoting upstream:
    "Bearssl is considered alpha-quality software, which means that it
    runs but it probably has bugs, some of which being certainly
    exploitable vulnerabilities."
    EOS
  end

  test do
    # Generate a dummy test cert. Is immediately deleted at test completion.
    system "openssl", "req", "-x509", "-newkey", "rsa:4096", "-keyout", "key.pem",
           "-out", "cert.pem", "-days", "1", "-nodes", "-subj", "/CN=test"

    output = shell_output("#{bin}/brssl verify cert.pem 2>&1", 1)
    assert_match "Key type: RSA (4096 bits)", output
  end
end
