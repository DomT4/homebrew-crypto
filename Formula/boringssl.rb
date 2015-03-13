class Boringssl < Formula
  homepage "https://boringssl.googlesource.com"
  url "https://boringssl.googlesource.com/boringssl.git", :revision => "bf0df92964565f819881e78ff3bfb5343e95e130"
  version "0.0.0.13" # Fake version so we can update the formula regularly & easily.

  keg_only :provided_by_osx, <<-EOS.undent
    "Apple provides a deprecated OpenSSL, which conflicts with this.
    It also conflicts with our shipped OpenSSL and LibreSSL"
  EOS

  option "without-documentation", "Skip building the documentation."

  depends_on "ninja" => :build
  depends_on "cmake" => :build
  depends_on "go" => :build if build.with? "documentation"

  def install
    if build.with? "documentation"
      mkdir_p share/"doc"
      cd "util" do
        system "go", "build", "doc.go"
        system buildpath/"util/doc", "--config", buildpath/"util/doc.config", "--out", "#{share}/doc"
      end
    end

    mkdir "build"
    cd "build" do
      system "cmake", "-GNinja", ".."
      system "ninja"

      # There's no real Makefile as such. We have to handle this manually.
      bin.install "tool/bssl"
      lib.install "crypto/libcrypto.a", "ssl/libssl.a"
    end
    include.install Dir["include/*"]
  end
end
