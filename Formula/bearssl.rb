class Bearssl < Formula
  desc "Implementation of the SSL/TLS protocol written in C"
  homepage "https://bearssl.org/index.html"
  url "https://bearssl.org/bearssl-0.5.tar.gz"
  sha256 "400f7027f309f5c0e3784ad1f5a612cfadfa108a33d867f50c75974cabd7830c"
  head "https://www.bearssl.org/git/BearSSL", :using => :git

  depends_on "doxygen" => [:build, :optional]
  depends_on "graphviz" => :build if build.with? "doxygen"

  def install
    system "make"

    if build.with? "doxygen"
      system "doxygen"
      doc.install Dir["apidoc/html/*"]
    end

    cd "build" do
      # Run the crypto testsuite.
      system "./testcrypto", "all"

      bin.install "brssl"
      lib.install "libbearssl.a"
      lib.install "libbearssl.so" => "libbearssl.dylib"
    end
    (include/"bearssl").install Dir["inc/*.h"]
  end

  test do
    # Generate a dummy test cert. Is immediately deleted at test completion.
    system "openssl", "req", "-x509", "-newkey", "rsa:4096", "-keyout", "key.pem",
           "-out", "cert.pem", "-days", "1", "-nodes", "-subj", "/CN=test"

    output = shell_output("#{bin}/brssl verify cert.pem 2>&1", 1)
    assert_match "Key type: RSA (4096 bits)", output
  end
end
