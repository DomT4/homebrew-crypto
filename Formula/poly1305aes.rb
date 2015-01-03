class Poly1305aes < Formula
  homepage "http://cr.yp.to/mac.html"
  url "http://cr.yp.to/mac/poly1305aes-20050218.tar.gz"
  sha256 "1ff45c186f85a8a2533d88ae10b6ea7510be93d592c22d751db21023ef0a7133"

  fails_with :clang do
    "refuses to compile"
  end

  def install
    ENV.append_to_cflags "-O2"
    system "make", "CC=#{ENV.cc}", "CFLAGS=#{ENV.cflags}"

    # There is no "install" stage, handle it manually.
    bin.install "poly1305aes.impl.check", "x86cpuid"
    libexec.install "test-aes", "poly1305aes-speed"
    lib.install "poly1305aes.a", "cpucycles.a"
    include.install "poly1305aes.h"
  end

  # Improve this later.
  test do
    system "#{bin}/x86cpuid"
  end
end
