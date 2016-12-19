class Bearssl < Formula
  desc "Implementation of the SSL/TLS protocol written in C"
  homepage "https://bearssl.org/index.html"
  url "https://bearssl.org/bearssl-0.2.tar.gz"
  sha256 "8d7640b4112e7cf677a4a5f22a997cf89c4a18e51bc4843f6f16b7db7fe93f73"
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
