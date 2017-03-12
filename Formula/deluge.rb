class Deluge < Formula
  include Language::Python::Virtualenv

  desc "Popular open-source bittorrent client"
  homepage "http://deluge-torrent.org/"
  url "http://download.deluge-torrent.org/source/deluge-1.3.14.tar.xz"
  sha256 "02398c71bac05e74c9c2d9bfd3e14e722b64e3c6ffa477424713582b65b895b6"

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
  depends_on "openjpeg" # For Pillow

  resource "appdirs" do
    url "https://files.pythonhosted.org/packages/48/69/d87c60746b393309ca30761f8e2b49473d43450b150cb08f3c6df5c11be5/appdirs-1.4.3.tar.gz"
    sha256 "9e5896d1372858f8dd3344faf4e5014d21849c756c8d5701f78f8a103b372d92"
  end

  resource "asn1crypto" do
    url "https://files.pythonhosted.org/packages/ce/39/17e90c2efacc4060915f7d1f9b8d2a5b20e54e46233bdf3092e68193407d/asn1crypto-0.21.1.tar.gz"
    sha256 "4e6d7b22814d680114a439faafeccb9402a78095fb23bf0b25f9404c6938a017"
  end

  resource "attrs" do
    url "https://files.pythonhosted.org/packages/01/b0/3ac73bf6df716a38568a16f6a9cbc46cc9e8ed6fe30c8768260030db55d4/attrs-16.3.0.tar.gz"
    sha256 "80203177723e36f3bbe15aa8553da6e80d47bfe53647220ccaa9ad7a5e473ccc"
  end

  resource "Automat" do
    url "https://files.pythonhosted.org/packages/73/5a/e5dc9a87e5795ba164e012f2b1cd659e31b722355b79e934e0af892d0493/Automat-0.5.0.tar.gz"
    sha256 "4889ec6763377432ec4db265ad552bbe956768ea3fff39014855308ba79dd7c2"
  end

  resource "cffi" do
    url "https://files.pythonhosted.org/packages/a1/32/e3d6c3a8b5461b903651dd6ce958ed03c093d2e00128e3f33ea69f1d7965/cffi-1.9.1.tar.gz"
    sha256 "563e0bd53fda03c151573217b3a49b3abad8813de9dd0632e10090f6190fdaf8"
  end

  resource "chardet" do
    url "https://files.pythonhosted.org/packages/7d/87/4e3a3f38b2f5c578ce44f8dc2aa053217de9f0b6d737739b0ddac38ed237/chardet-2.3.0.tar.gz"
    sha256 "e53e38b3a4afe6d1132de62b7400a4ac363452dc5dfcf8d88e8e0cce663c68aa"
  end

  resource "constantly" do
    url "https://files.pythonhosted.org/packages/95/f1/207a0a478c4bb34b1b49d5915e2db574cadc415c9ac3a7ef17e29b2e8951/constantly-15.1.0.tar.gz"
    sha256 "586372eb92059873e29eba4f9dec8381541b4d3834660707faf8ba59146dfc35"
  end

  resource "cryptography" do
    url "https://files.pythonhosted.org/packages/ec/5f/d5bc241d06665eed93cd8d3aa7198024ce7833af7a67f6dc92df94e00588/cryptography-1.8.1.tar.gz"
    sha256 "323524312bb467565ebca7e50c8ae5e9674e544951d28a2904a50012a8828190"
  end

  resource "enum34" do
    url "https://files.pythonhosted.org/packages/bf/3e/31d502c25302814a7c2f1d3959d2a3b3f78e509002ba91aea64993936876/enum34-1.1.6.tar.gz"
    sha256 "8ad8c4783bf61ded74527bffb48ed9b54166685e4230386a9ed9b1279e2df5b1"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/d8/82/28a51052215014efc07feac7330ed758702fc0581347098a81699b5281cb/idna-2.5.tar.gz"
    sha256 "3cb5ce08046c4e3a560fc02f138d0ac63e00f8ce5901a56b32ec8b7994082aab"
  end

  resource "incremental" do
    url "https://files.pythonhosted.org/packages/da/b0/32233c9e84b0d44b39015fba8fec03e88053723c1b455925081dc6ccd9e7/incremental-16.10.1.tar.gz"
    sha256 "14ad6b720ec47aad6c9caa83e47db1843e2b9b98742da5dda08e16a99f400342"
  end

  resource "ipaddress" do
    url "https://files.pythonhosted.org/packages/4e/13/774faf38b445d0b3a844b65747175b2e0500164b7c28d78e34987a5bfe06/ipaddress-1.0.18.tar.gz"
    sha256 "5d8534c8e185f2d8a1fda1ef73f2c8f4b23264e8e30063feeb9511d492a413e1"
  end

  resource "olefile" do
    url "https://files.pythonhosted.org/packages/35/17/c15d41d5a8f8b98cc3df25eb00c5cee76193114c78e5674df6ef4ac92647/olefile-0.44.zip"
    sha256 "61f2ca0cd0aa77279eb943c07f607438edf374096b66332fae1ee64a6f0f73ad"
  end

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/c6/70/bb32913de251017e266c5114d0a645f262fb10ebc9bf6de894966d124e35/packaging-16.8.tar.gz"
    sha256 "5d50835fdf0a7edf0b55e311b7c887786504efea1177abd7e69329a8e5ea619e"
  end

  resource "Pillow" do
    url "https://files.pythonhosted.org/packages/8d/80/eca7a2d1a3c2dafb960f32f844d570de988e609f5fd17de92e1cf6a01b0a/Pillow-4.0.0.tar.gz"
    sha256 "ee26d2d7e7e300f76ba7b796014c04011394d0c4a5ed9a288264a3e443abca50"
  end

  resource "pyasn1" do
    url "https://files.pythonhosted.org/packages/69/17/eec927b7604d2663fef82204578a0056e11e0fc08d485fdb3b6199d9b590/pyasn1-0.2.3.tar.gz"
    sha256 "738c4ebd88a718e700ee35c8d129acce2286542daa80a82823a7073644f706ad"
  end

  resource "pyasn1-modules" do
    url "https://files.pythonhosted.org/packages/60/32/7703bccdba05998e4ff04db5038a6695a93bedc45dcf491724b85b5db76a/pyasn1-modules-0.0.8.tar.gz"
    sha256 "10561934f1829bcc455c7ecdcdacdb4be5ffd3696f26f468eb6eb41e107f3837"
  end

  resource "pycparser" do
    url "https://files.pythonhosted.org/packages/be/64/1bb257ffb17d01f4a38d7ce686809a736837ad4371bcc5c42ba7a715c3ac/pycparser-2.17.tar.gz"
    sha256 "0aac31e917c24cb3357f5a4d5566f2cc91a19ca41862f6c3c22dc60a629673b6"
  end

  resource "pyOpenSSL" do
    url "https://files.pythonhosted.org/packages/0c/d6/b1fe519846a21614fa4f8233361574eddb223e0bc36b182140d916acfb3b/pyOpenSSL-16.2.0.tar.gz"
    sha256 "7779a3bbb74e79db234af6a08775568c6769b5821faecf6e2f4143edb227516e"
  end

  resource "pyparsing" do
    url "https://files.pythonhosted.org/packages/3c/ec/a94f8cf7274ea60b5413df054f82a8980523efd712ec55a59e7c3357cf7c/pyparsing-2.2.0.tar.gz"
    sha256 "0832bcf47acd283788593e7a0f542407bd9550a55a8a8435214a1960e04bcb04"
  end

  resource "pyxdg" do
    url "https://files.pythonhosted.org/packages/26/28/ee953bd2c030ae5a9e9a0ff68e5912bd90ee50ae766871151cd2572ca570/pyxdg-0.25.tar.gz"
    sha256 "81e883e0b9517d624e8b0499eb267b82a815c0b7146d5269f364988ae031279d"
  end

  resource "service_identity" do
    url "https://files.pythonhosted.org/packages/f3/2a/7c04e7ab74f9f2be026745a9ffa81fd9d56139fa6f5f4b4c8a8c07b2bfba/service_identity-16.0.0.tar.gz"
    sha256 "0630e222f59f91f3db498be46b1d879ff220955d7bbad719a5cb9ad14e3c3036"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/b3/b2/238e2590826bfdd113244a40d9d3eb26918bd798fc187e2360a8367068db/six-1.10.0.tar.gz"
    sha256 "105f8d68616f8248e24bf0e9372ef04d3cc10104f1980f54d57b2ce73a5ad56a"
  end

  resource "Twisted" do
    url "https://files.pythonhosted.org/packages/d2/5d/ed5071740be94da625535f4333793d6fd238f9012f0fee189d0c5d00bd74/Twisted-17.1.0.tar.bz2"
    sha256 "dbf211d70afe5b4442e3933ff01859533eba9f13d8b3e2e1b97dc2125e2d44dc"
  end

  resource "zope.interface" do
    url "https://files.pythonhosted.org/packages/44/af/cea1e18bc0d3be0e0824762d3236f0e61088eeed75287e7b854d65ec9916/zope.interface-4.3.3.tar.gz"
    sha256 "8780ef68ca8c3fe1abb30c058a59015129d6e04a6b02c2e56b9c7de6078dfa88"
  end

  # For Web UI
  resource "MarkupSafe" do
    url "https://files.pythonhosted.org/packages/4d/de/32d741db316d8fdb7680822dd37001ef7a448255de9699ab4bfcbdf4172b/MarkupSafe-1.0.tar.gz"
    sha256 "a6be69091dac236ea9c6bc7d012beab42010fa914c459791d627dad4910eb665"
  end

  resource "Mako" do
    url "https://files.pythonhosted.org/packages/56/4b/cb75836863a6382199aefb3d3809937e21fa4cb0db15a4f4ba0ecc2e7e8e/Mako-1.0.6.tar.gz"
    sha256 "48559ebd872a8e77f92005884b3d88ffae552812cdf17db6768e5c3be5ebbe0d"
  end

  def install
    venv = virtualenv_create(libexec)

    resource("Pillow").stage do
      inreplace "setup.py" do |s|
        sdkprefix = MacOS::CLT.installed? ? "" : MacOS.sdk_path
        s.gsub! "ZLIB_ROOT = None", "ZLIB_ROOT = ('#{sdkprefix}/usr/lib', '#{sdkprefix}/usr/include')"
        s.gsub! "JPEG_ROOT = None", "JPEG_ROOT = ('#{Formula["jpeg"].opt_prefix}/lib', '#{Formula["jpeg"].opt_prefix}/include')"
        s.gsub! "FREETYPE_ROOT = None", "FREETYPE_ROOT = ('#{Formula["freetype"].opt_prefix}/lib', '#{Formula["freetype"].opt_prefix}/include')"
      end

      # avoid triggering "helpful" distutils code that doesn't recognize Xcode 7 .tbd stubs
      ENV.delete "SDKROOT"
      ENV.append "CFLAGS", "-I#{MacOS.sdk_path}/System/Library/Frameworks/Tk.framework/Versions/8.5/Headers" unless MacOS::CLT.installed?
      venv.pip_install Pathname.pwd
    end

    res = resources.map(&:name).to_set - ["Pillow"]

    res.each do |r|
      venv.pip_install resource(r)
    end

    venv.pip_install_and_link buildpath
  end

  test do
    pid = fork do
      exec "#{bin}/deluge-web --port=8081"
    end
    sleep 2

    begin
      assert_match "Deluge: Web UI #{version}", shell_output("curl localhost:8081")
    ensure
      Process.kill("SIGINT", pid)
      Process.wait(pid)
    end
  end
end
