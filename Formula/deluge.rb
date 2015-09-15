class Deluge < Formula
  desc "Popular open-source bittorrent client"
  homepage "http://deluge-torrent.org/"
  url "http://download.deluge-torrent.org/source/deluge-1.3.12.tar.bz2"
  sha256 "565745b2a3f0567fc007dbdfeea2aa96a6bebd7dbdda2ec932a3017c66613c93"

  head "git://deluge-torrent.org/deluge.git", :branch => "develop"

  depends_on :python if MacOS.version <= :snow_leopard
  depends_on "intltool" => :build
  depends_on "gettext"
  depends_on "freetype"
  depends_on "geoip"
  depends_on "boost-python"
  depends_on "libtorrent-rasterbar" => "with-python"
  depends_on "pygtk" => "with-libglade"
  depends_on "gtk-mac-integration"
  depends_on "librsvg"
  depends_on "openssl"

  resource "setuptools" do
    url "https://pypi.python.org/packages/source/s/setuptools/setuptools-18.3.1.tar.gz"
    sha256 "2fa230727104b07e522deec17929e84e041c9047e392c055347a02b0d5ca874d"
  end

  resource "six" do
    url "https://pypi.python.org/packages/source/s/six/six-1.9.0.tar.gz"
    sha256 "e24052411fc4fbd1f672635537c3fc2330d9481b18c0317695b46259512c91d5"
  end

  resource "service_identity" do
    url "https://pypi.python.org/packages/source/s/service_identity/service_identity-14.0.0.tar.gz"
    sha256 "3105a319a7c558490666694f599be0c377ad54824eefb404cde4ce49e74a4f5a"
  end

  resource "zope.interface" do
    url "https://pypi.python.org/packages/source/z/zope.interface/zope.interface-4.1.2.tar.gz"
    sha256 "441fefcac1fbac57c55239452557d3598571ab82395198b2565a29d45d1232f6"
  end

  resource "cffi" do
    url "https://pypi.python.org/packages/source/c/cffi/cffi-1.2.1.tar.gz"
    sha256 "eab571deb0a152e2f53c404c08a94870a131526896cad08cd43bf86ce3771e3d"
  end

  resource "enum34" do
    url "https://pypi.python.org/packages/source/e/enum34/enum34-1.0.4.tar.gz"
    sha256 "d3c19f26a6a34629c18c775f59dfc5dd595764c722b57a2da56ebfb69b94e447"
  end

  resource "pyasn1" do
    url "https://pypi.python.org/packages/source/p/pyasn1/pyasn1-0.1.8.tar.gz"
    sha256 "5d33be7ca0ec5997d76d29ea4c33b65c00c0231407fff975199d7f40530b8347"
  end

  resource "pycparser" do
    url "https://pypi.python.org/packages/source/p/pycparser/pycparser-2.14.tar.gz"
    sha256 "7959b4a74abdc27b312fed1c21e6caf9309ce0b29ea86b591fd2e99ecdf27f73"
  end

  resource "cryptography" do
    url "https://pypi.python.org/packages/source/c/cryptography/cryptography-1.0.1.tar.gz"
    sha256 "cfe3092a6a929bc3a97c3b752044b79d09c9b210860c7b4eb5061aea29dcbfd3"
  end

  resource "pyopenssl" do
    url "https://pypi.python.org/packages/source/p/pyOpenSSL/pyOpenSSL-0.15.1.tar.gz"
    sha256 "f0a26070d6db0881de8bcc7846934b7c3c930d8f9c79d45883ee48984bc0d672"
  end

  resource "twisted" do
    url "https://pypi.python.org/packages/source/T/Twisted/Twisted-15.4.0.tar.bz2"
    sha256 "78862662fa9ae29654bc2b9d349c3f1d887e6b2ed978512c4442d53ea861f05c"
  end

  resource "slimit" do
    url "https://pypi.python.org/packages/source/s/slimit/slimit-0.8.1.zip"
    sha256 "f433dcef899f166b207b67d91d3f7344659cb33b8259818f084167244e17720b"
  end

  resource "pyxdg" do
    url "https://pypi.python.org/packages/source/p/pyxdg/pyxdg-0.25.tar.gz"
    sha256 "81e883e0b9517d624e8b0499eb267b82a815c0b7146d5269f364988ae031279d"
  end

  resource "chardet" do
    url "https://pypi.python.org/packages/source/c/chardet/chardet-2.3.0.tar.gz"
    sha256 "e53e38b3a4afe6d1132de62b7400a4ac363452dc5dfcf8d88e8e0cce663c68aa"
  end

  resource "setproctitle" do
    url "https://pypi.python.org/packages/source/s/setproctitle/setproctitle-1.1.9.tar.gz"
    sha256 "1c3414d18f9cacdab78b0ffd8e886d56ad45f22e55001a72aaa0b2aeb56a0ad7"
  end

  resource "pillow" do
    url "https://pypi.python.org/packages/source/P/Pillow/Pillow-2.9.0.tar.gz"
    sha256 "0f179d7e75e7c83b6341b9595ca1f394de7081484a9e352ad66d553a1c3daa29"
  end

  # For Web UI
  resource "mako" do
    url "https://pypi.python.org/packages/source/M/Mako/Mako-1.0.2.tar.gz"
    sha256 "2550c2e4528820db68cbcbe668add5c71ab7fa332b7eada7919044bf8697679e"
  end

  def install
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python2.7/site-packages"

    # Pillow requires some special handling. Boo.
    resource("pillow").stage do
      inreplace "setup.py", "'brew', '--prefix'", "'#{HOMEBREW_PREFIX}/bin/brew', '--prefix'"
      system "python", *Language::Python.setup_install_args(libexec/"vendor")
    end

    res = %w[setuptools six service_identity zope.interface cffi enum34 pyasn1
             pycparser cryptography pyopenssl slimit pyxdg chardet setproctitle
             mako twisted]

    res.each do |r|
      resource(r).stage do
        system "python", *Language::Python.setup_install_args(libexec/"vendor")
      end
    end

    # namespace package hint
    touch libexec/"vendor/lib/python2.7/site-packages/zope/__init__.py"

    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python2.7/site-packages"
    system "python", *Language::Python.setup_install_args(libexec)

    bin.install Dir["#{libexec}/bin/*"]
    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end

  test do
    pid = fork do
      exec "#{bin}/deluge-web --port=8081"
    end
    sleep 2

    begin
      assert_match /Deluge: Web UI #{version}/, shell_output("curl localhost:8081")
    ensure
      Process.kill("SIGINT", pid)
      Process.wait(pid)
    end
  end
end
