class Bearssl < Formula
  desc "Implementation of the SSL/TLS protocol written in C"
  homepage "https://bearssl.org/index.html"
  url "https://bearssl.org/bearssl-0.6.tar.gz"
  sha256 "6705bba1714961b41a728dfc5debbe348d2966c117649392f8c8139efc83ff14"
  head "https://www.bearssl.org/git/BearSSL", :using => :git

  depends_on "doxygen" => :build
  depends_on "graphviz" => :build

  def install
    system "make"

    system "doxygen"
    doc.install Dir["apidoc/html/*"]

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
