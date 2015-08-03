class Boringssl < Formula
  desc "A Google fork of OpenSSL"
  homepage "https://boringssl.googlesource.com"
  url "https://boringssl.googlesource.com/boringssl.git", :revision => "16f774f8bf13829fef162c7790661785dc4721b2"
  version "0.0.0.33" # Fake version so we can update the formula regularly & easily.
  head "https://boringssl.googlesource.com/boringssl.git"

  keg_only :provided_by_osx, <<-EOS.undent
    "Apple provides a deprecated OpenSSL, which conflicts with this.
    It also conflicts with our shipped OpenSSL and LibreSSL"
  EOS

  option "without-documentation", "Build the documentation."

  depends_on "ninja" => :build
  depends_on "cmake" => :build
  depends_on "go" => :build if build.with? "documentation"

  def install
    if build.with? "documentation"
      (doc/"boringssl").mkpath
      cd "util" do
        system "go", "build", "doc.go"
        system buildpath/"util/doc", "--config", buildpath/"util/doc.config", "--out", doc
      end
    end

    mkdir "build" do
      system "cmake", "-GNinja", ".."
      system "ninja"

      # There's no real Makefile as such. We have to handle this manually.
      bin.install "tool/bssl"
      lib.install "crypto/libcrypto.a", "ssl/libssl.a"
    end
    include.install Dir["include/*"]
  end

  test do
    (testpath/"testfile.txt").write("This is a test file")
    expected_checksum = "91b7b0b1e27bfbf7bc646946f35fa972c47c2d32"
    assert_match expected_checksum, shell_output("#{bin}/bssl sha1sum testfile.txt")
  end
end
