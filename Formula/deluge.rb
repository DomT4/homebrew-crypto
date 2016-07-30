class Deluge < Formula
  desc "Popular open-source bittorrent client"
  homepage "http://deluge-torrent.org/"
  url "http://download.deluge-torrent.org/source/deluge-1.3.13.tar.xz"
  sha256 "fe8059a66834abd656693a8736b0829cb3342bb803c55384abad3756097d394e"

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
    url "https://files.pythonhosted.org/packages/9f/7c/0a33c528164f1b7ff8cf0684cf88c2e733c8ae0119ceca4a3955c7fc059d/setuptools-23.1.0.tar.gz"
    sha256 "4e269d36ba2313e6236f384b36eb97b3433cf99a16b94c74cca7eee2b311f2be"
  end

  resource "attrs" do
    url "https://files.pythonhosted.org/packages/89/15/80d388d696c8c8ba14874635207aa698eb30ef1242dbb54d9eccf0e927ff/attrs-16.0.0.tar.gz"
    sha256 "de6827a454d23716442b571bb35b0efb32a1b5c1037f09cfc7aaf405c7d68abc"
  end

  resource "cffi" do
    url "https://files.pythonhosted.org/packages/83/3c/00b553fd05ae32f27b3637f705c413c4ce71290aa9b4c4764df694e906d9/cffi-1.7.0.tar.gz"
    sha256 "6ed5dd6afd8361f34819c68aaebf9e8fc12b5a5893f91f50c9e50c8886bb60df"
  end

  resource "chardet" do
    url "https://files.pythonhosted.org/packages/7d/87/4e3a3f38b2f5c578ce44f8dc2aa053217de9f0b6d737739b0ddac38ed237/chardet-2.3.0.tar.gz"
    sha256 "e53e38b3a4afe6d1132de62b7400a4ac363452dc5dfcf8d88e8e0cce663c68aa"
  end

  resource "cryptography" do
    url "https://files.pythonhosted.org/packages/a9/5b/a383b3a778609fe8177bd51307b5ebeee369b353550675353f46cb99c6f0/cryptography-1.4.tar.gz"
    sha256 "bb149540ed90c4b2171bf694fe6991d6331bc149ae623c8ff419324f4222d128"
  end

  resource "enum34" do
    url "https://files.pythonhosted.org/packages/bf/3e/31d502c25302814a7c2f1d3959d2a3b3f78e509002ba91aea64993936876/enum34-1.1.6.tar.gz"
    sha256 "8ad8c4783bf61ded74527bffb48ed9b54166685e4230386a9ed9b1279e2df5b1"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/fb/84/8c27516fbaa8147acd2e431086b473c453c428e24e8fb99a1d89ce381851/idna-2.1.tar.gz"
    sha256 "ed36f281aebf3cd0797f163bb165d84c31507cedd15928b095b1675e2d04c676"
  end

  resource "ipaddress" do
    url "https://files.pythonhosted.org/packages/cd/c5/bd44885274379121507870d4abfe7ba908326cf7bfd50a48d9d6ae091c0d/ipaddress-1.0.16.tar.gz"
    sha256 "5a3182b322a706525c46282ca6f064d27a02cffbd449f9f47416f1dc96aa71b0"
  end

  resource "Pillow" do
    url "https://files.pythonhosted.org/packages/e0/27/f61098a12f14690689924de93ffdd101463083a80bf8ff3e0c218addf05b/Pillow-3.3.0.tar.gz"
    sha256 "031e7c9c885a4f343d1ad366c7fd2340449dc70318acb4a28d6411994f0accd1"
  end

  resource "pyasn1" do
    url "https://files.pythonhosted.org/packages/f7/83/377e3dd2e95f9020dbd0dfd3c47aaa7deebe3c68d3857a4e51917146ae8b/pyasn1-0.1.9.tar.gz"
    sha256 "853cacd96d1f701ddd67aa03ecc05f51890135b7262e922710112f12a2ed2a7f"
  end

  resource "pyasn1-modules" do
    url "https://files.pythonhosted.org/packages/60/32/7703bccdba05998e4ff04db5038a6695a93bedc45dcf491724b85b5db76a/pyasn1-modules-0.0.8.tar.gz"
    sha256 "10561934f1829bcc455c7ecdcdacdb4be5ffd3696f26f468eb6eb41e107f3837"
  end

  resource "pycparser" do
    url "https://files.pythonhosted.org/packages/6d/31/666614af3db0acf377876d48688c5d334b6e493b96d21aa7d332169bee50/pycparser-2.14.tar.gz"
    sha256 "7959b4a74abdc27b312fed1c21e6caf9309ce0b29ea86b591fd2e99ecdf27f73"
  end

  resource "pyOpenSSL" do
    url "https://files.pythonhosted.org/packages/77/f2/bccec75ca4280a9fa762a90a1b8b152a22eac5d9c726d7da1fcbfe0a20e6/pyOpenSSL-16.0.0.tar.gz"
    sha256 "363d10ee43d062285facf4e465f4f5163f9f702f9134f0a5896f134cbb92d17d"
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
    url "https://files.pythonhosted.org/packages/c0/7c/c1e5b61e30b7ffc96576d2a922615c8068e6996a622be813fc626cef07aa/Twisted-16.3.0.tar.bz2"
    sha256 "d588a87243ac20e72daef520c1248cb5391e1d583999b8c29a7ae5f97474974f"
  end

  resource "zope.interface" do
    url "https://files.pythonhosted.org/packages/ea/a3/38bdc8e8bd068ea5b4d21a2d80eca1547cd8509318e8d7c875f7247abe43/zope.interface-4.2.0.tar.gz"
    sha256 "36762743940a075283e1fb22a2ec9e8231871dace2aa00599511ddc4edf0f8f9"
  end

  # For Web UI
  resource "MarkupSafe" do
    url "https://files.pythonhosted.org/packages/c0/41/bae1254e0396c0cc8cf1751cb7d9afc90a602353695af5952530482c963f/MarkupSafe-0.23.tar.gz"
    sha256 "a4ec1aff59b95a14b45eb2e23761a0179e98319da5a7eb76b56ea8cdc7b871c3"
  end

  resource "Mako" do
    url "https://files.pythonhosted.org/packages/7a/ae/925434246ee90b42e8ef57d3b30a0ab7caf9a2de3e449b876c56dcb48155/Mako-1.0.4.tar.gz"
    sha256 "fed99dbe4d0ddb27a33ee4910d8708aca9ef1fe854e668387a9ab9a90cbf9059"
  end

  def install
    # Required to give Pillow a gentle kick on finding freetype correctly.
    ENV.append "CFLAGS", "-I#{Formula["freetype"].opt_include}/freetype2"

    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python2.7/site-packages"
    %w[
      setuptools attrs cffi chardet cryptography enum34 idna ipaddress
      pyasn1 pyasn1-modules pycparser Pillow pyOpenSSL pyxdg six
      service_identity Twisted zope.interface MarkupSafe Mako
    ].each do |r|
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
      assert_match "Deluge: Web UI #{version}", shell_output("curl localhost:8081")
    ensure
      Process.kill("SIGINT", pid)
      Process.wait(pid)
    end
  end
end
