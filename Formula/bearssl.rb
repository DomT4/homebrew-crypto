class Bearssl < Formula
  desc "Implementation of the SSL/TLS protocol written in C"
  homepage "https://bearssl.org/index.html"
  url "https://bearssl.org/bearssl-0.3.tar.gz"
  sha256 "2797ccb08f41e1aeabb625c8682f4b2e61f1827695d4ea10a57c5b62175a3b22"
  head "https://www.bearssl.org/git/BearSSL", :using => :git

  depends_on "doxygen" => [:build, :optional]
  depends_on "graphviz" => :build if build.with? "doxygen"

  def install
    system "make"

    if build.with? "doxygen"
      system "doxygen"
      doc.install Dir["apidoc/html/*"]
    end

    # No "make install".
    cd "build" do
      bin.install "brssl"
      lib.install "libbearssl.a"
      lib.install "libbearssl.so" => "libbearssl.dylib"
    end
    (include/"bearssl").install Dir["inc/*.h"]
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
