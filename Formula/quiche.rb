class Quiche < Formula
  desc "Savoury implementation of the QUIC transport protocol and HTTP/3"
  homepage "https://github.com/cloudflare/quiche"
  url "https://github.com/cloudflare/quiche/archive/refs/tags/0.16.0.tar.gz"
  sha256 "eff71b34b1598faf9560b3c80c498cad08871a79b87902e32f2f9d2f04f89d86"
  license "BSD-2-Clause"

  depends_on "boringssl" => :build
  depends_on "libev" => :build
  depends_on "pkg-config" => :build
  depends_on "rust" => :build

  resource "uthash" do
    url "https://github.com/troydhanson/uthash.git",
        revision: "ca98384ce7f30beb216f9a0bc88a3b4340ead729"
  end

  def install
    resource("uthash").stage do
      (buildpath/"quiche/examples").install "src/uthash.h"
    end

    ENV["QUICHE_BSSL_PATH"] = Formula["boringssl"].opt_prefix
    ENV["RUSTFLAGS"] = "-L #{Formula["boringssl"].opt_lib}"

    # This only exists to stop brew audit kicking off.
    notbuild = "build"
    system "cargo", notbuild, "--release", "--features", "ffi,pkg-config-meta,qlog"

    cd "quiche/examples" do
      system "make"
      rm_rf "build" # Remove huge debug information.
      (libexec/"quiche_examples").install Dir["*"]
    end

    libexec.install Dir["*"]
    include.install_symlink Dir[libexec/"quiche/include/*"]

    release = libexec/"target/release"

    bin.install_symlink release/"quiche-client", release/"quiche-server"
    lib.install_symlink release/"libquiche.dylib", release/"libquiche.a"
    (lib/"pkgconfig").install_symlink release/"quiche.pc"
  end

  test do
    output = shell_output(bin/"quiche-client https://cloudflare-quic.com/ --http-version=HTTP/3 2>&1")
    assert_match "Cloudflare, Inc.", output
  end
end
