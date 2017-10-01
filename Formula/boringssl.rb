class Boringssl < Formula
  desc "Google fork of OpenSSL"
  homepage "https://boringssl.googlesource.com/boringssl"
  url "https://boringssl.googlesource.com/boringssl.git",
      :revision => "575334657fcb66a4861c9d125430b2aef60476a6"
  version "0.0.0.79" # Fake version so we can update the formula regularly.
  head "https://boringssl.googlesource.com/boringssl.git"

  keg_only <<-EOS.undent
    Apple provides an old OpenSSL, which conflicts with this.
    It also conflicts with Homebrew's shipped OpenSSL and LibreSSL
  EOS

  depends_on "ninja" => :build
  depends_on "cmake" => :build
  depends_on "go" => :build

  def install
    doc.mkpath
    cd "util" do
      system "go", "build", "doc.go"
      system buildpath/"util/doc", "--config", buildpath/"util/doc.config", "--out", doc
    end

    mkdir "build" do
      system "cmake", "-GNinja", "..", "-DBUILD_SHARED_LIBS=1", *std_cmake_args
      system "ninja"

      # There's no real Makefile as such. We have to handle this manually.
      bin.install "tool/bssl"
      lib.install "crypto/libcrypto.dylib", "ssl/libssl.dylib"
    end
    include.install Dir["include/*"]
  end

  test do
    (testpath/"testfile.txt").write "This is a test file"
    expected_checksum = "e2d0fe1585a63ec6009c8016ff8dda8b17719a637405a4e23c0ff81339148249"
    assert_match expected_checksum, shell_output("#{bin}/bssl sha256sum testfile.txt")
  end
end
