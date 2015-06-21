class Deluge < Formula
  desc "Popular open-source bittorrent client"
  homepage "http://deluge-torrent.org/"
  url "http://download.deluge-torrent.org/source/deluge-1.3.11.tar.gz"
  sha256 "80b0a2a3460d52a5f53df26a9ce314e3e792f2e3f45b7c389140fd830bdee1b0"

  head "git://deluge-torrent.org/deluge.git", :branch => "develop"

  depends_on :python if MacOS.version <= :snow_leopard
  depends_on "intltool" => :build
  depends_on "gettext"
  depends_on "freetype"
  depends_on "geoip"
  depends_on "libtorrent-rasterbar" => "with-python"
  depends_on "pygtk" => "with-libglade"
  depends_on "librsvg"

  # Zope tantrums horribly if not installed directly in the Python dir.
  depends_on "zope.interface" => :python
  # Likewise, Twisted has a "fun" time finding service_identity unless global
  depends_on "service_identity" => :python

  resource "twisted" do
    url "https://pypi.python.org/packages/source/T/Twisted/Twisted-14.0.2.tar.bz2"
    sha256 "038096be8723b678e2ead323b14d0d3e2db161e0c7ce3c98fdd18ca5869acb71"
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
    url "https://pypi.python.org/packages/source/s/setproctitle/setproctitle-1.1.8.tar.gz"
    sha256 "b564cf6488217c7a4632a9fe646fc3a3bea2f9712b4e667e9632b870d1a58211"
  end

  resource "pillow" do
    url "https://pypi.python.org/packages/source/P/Pillow/Pillow-2.7.0.tar.gz"
    sha256 "26e9320e73f5821826b6b2408a3bff0a8c29e45159530069a117efd39ef619f8"
  end

  # For Web UI
  resource "mako" do
    url "https://pypi.python.org/packages/source/M/Mako/Mako-1.0.1.tar.gz"
    sha256 "45f0869febea59dab7efd256fb451c377cbb7947bef386ff0bb44627c31a8d1c"
  end

  def install
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python2.7/site-packages"

    # Pillow requires some special handling. Boo.
    resource("pillow").stage do
      inreplace "setup.py", "'brew', '--prefix'", "'#{HOMEBREW_PREFIX}/bin/brew', '--prefix'"
      system "python", *Language::Python.setup_install_args(libexec/"vendor")
    end

    %w[slimit pyxdg chardet setproctitle mako twisted].each do |r|
      resource(r).stage do
        system "python", *Language::Python.setup_install_args(libexec/"vendor")
      end
    end

    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python2.7/site-packages"
    system "python", *Language::Python.setup_install_args(libexec)

    bin.install Dir["#{libexec}/bin/*"]
    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end
end
