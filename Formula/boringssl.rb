class Boringssl < Formula
  homepage "https://boringssl.googlesource.com"
  url "https://boringssl.googlesource.com/boringssl.git", :revision => "d3bcf13165899ba1a2acfbe57cf4a1365010de39"
  version "0.0.0.1" # Fake version so we can update the formula regularly & easily.

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
      mkdir_p "#{share}/doc"
      cd "util" do
        system "go", "build", "doc.go"
        system buildpath/"util/doc", "--config", buildpath/"util/doc.config", "--out", "#{share}/doc"
      end
    end

    mkdir "build"
    # Use Ninja instead of CMake directly because it's quicker, and less messy.
    cd "build" do
      system "cmake", "-GNinja", ".."
      system "ninja"

      # There's no real Makefile as such. We have to handle this manually.
      bin.install "tool/bssl"
      lib.install "crypto/libcrypto.a", "ssl/libssl.a"
    end
    include.install "include"
  end
end
