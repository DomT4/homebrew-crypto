class GoRequirement < Requirement
  fatal true

  satisfy(build_env: false) { which("go") }

  def message
    <<~EOS
      boringssl requires golang to compile:
        brew install go
    EOS
  end
end

class Boringssl < Formula
  desc "Google fork of OpenSSL"
  homepage "https://boringssl.googlesource.com/boringssl"
  url "https://boringssl.googlesource.com/boringssl.git",
      revision: "49350b22bebe0f0ec4d6279f268b19b612abba68"
  version "0.0.0.121" # Fake version so we can update the formula regularly.
  head "https://boringssl.googlesource.com/boringssl.git"

  keg_only <<~EOS
    Apple provides an old OpenSSL, which conflicts with this.
    It also conflicts with Homebrew's shipped OpenSSL and LibreSSL
  EOS

  depends_on "cmake" => :build
  depends_on GoRequirement => :build
  depends_on "ninja" => :build

  def install
    doc.mkpath
    cd "util" do
      system "go", "build", "doc.go"
      system "./doc", "--config", "doc.config", "--out", doc
    end

    mkdir "build" do
      system "cmake", "-GNinja", "..", *std_cmake_args
      system "ninja"
      system "go", "run", buildpath/"util/all_tests.go"

      # There's no real Makefile as such. We have to handle this manually.
      bin.install "tool/bssl"
      lib.install "crypto/libcrypto.a", "ssl/libssl.a"
    end
    include.install Dir["include/*"]
  end

  test do
    (testpath/"testfile.txt").write "This is a test file"
    expected_checksum = "e2d0fe1585a63ec6009c8016ff8dda8b17719a637405a4e23c0ff81339148249"
    assert_match expected_checksum, shell_output("#{bin}/bssl sha256sum testfile.txt")
  end
end
