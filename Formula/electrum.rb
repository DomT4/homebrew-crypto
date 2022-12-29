class Electrum < Formula
  include Language::Python::Virtualenv

  desc "Bitcoin thin client"
  homepage "https://electrum.org"
  url "https://download.electrum.org/4.3.2/Electrum-4.3.2.tar.gz"
  sha256 "bd3640ad3c1b29c7fafef3d03af8ee6cf79cb20fa1f90959eab75b97aa8d7ecd"

  bottle do
    root_url "https://dl.cloudsmith.io/public/homebrew-crypto/homebrew-crypto/raw/files/"
    sha256 arm64_big_sur: "24818be52857f5393569b3a696651641c983183570cb2f93022a6dcb63ad9c3f"
  end

  depends_on "cython" => :build
  # A little stunningly, cryptography now requires a whole Rust compiler to
  # build. We could use `CRYPTOGRAPHY_DONT_BUILD_RUST=1` but that seems to be
  # a hack rather than something upstream want to support indefinitely.
  depends_on "rust" => :build
  # This cannot use the formula from homebrew/core because the homebrew/core
  # one is built without required support for module recovery.
  depends_on "domt4/crypto/libsecp256k1" => :build
  depends_on "protobuf"
  depends_on "pyqt@5" # Check contrib/requirements/requirements-binaries-mac.txt
  depends_on "python"

  # It's really annoying this is required because it makes the build *a lot*
  # slower than it would otherwise be. Need to look into this more to see if
  # it's possible to just go back to using the core pyqt Python bindings
  # without constantly hitting `ModuleNotFoundError: No module named 'PyQt5.sip'`.
  resource "PyQt5-sip" do
    url "https://files.pythonhosted.org/packages/39/5f/fd9384fdcb9cd0388088899c110838007f49f5da1dd1ef6749bfb728a5da/PyQt5_sip-12.11.0.tar.gz"
    sha256 "b4710fd85b57edef716cc55fae45bfd5bfac6fc7ba91036f1dcc3f331ca0eb39"
  end
  # END of above notes.

  resource "aiohttp" do
    url "https://files.pythonhosted.org/packages/ff/4f/62d9859b7d4e6dc32feda67815c5f5ab4421e6909e48cbc970b6a40d60b7/aiohttp-3.8.3.tar.gz"
    sha256 "3828fb41b7203176b82fe5d699e0d845435f2374750a44b480ea6b930f6be269"
  end

  resource "aiohttp-socks" do
    url "https://files.pythonhosted.org/packages/83/f0/5b9cbceb80591731fcbf26fd03a44063d405f1b584e5b66462b7c5d27fed/aiohttp_socks-0.7.1.tar.gz"
    sha256 "2215cac4891ef3fa14b7d600ed343ed0f0a670c23b10e4142aa862b3db20341a"
  end

  resource "aiorpcX" do
    url "https://files.pythonhosted.org/packages/70/b2/77ab9e156152f2054b17115cf30bbb56766c4a8545ff323346434871bd88/aiorpcX-0.22.1.tar.gz"
    sha256 "6026f7bed3432e206589c94dcf599be8cd85b5736b118c7275845c1bd922a553"
  end

  resource "aiosignal" do
    url "https://files.pythonhosted.org/packages/ae/67/0952ed97a9793b4958e5736f6d2b346b414a2cd63e82d05940032f45b32f/aiosignal-1.3.1.tar.gz"
    sha256 "54cd96e15e1649b75d6c87526a6ff0b6c1b0dd3459f43d9ca11d48c339b68cfc"
  end

  resource "async-timeout" do
    url "https://files.pythonhosted.org/packages/54/6e/9678f7b2993537452710ffb1750c62d2c26df438aa621ad5fa9d1507a43a/async-timeout-4.0.2.tar.gz"
    sha256 "2163e1640ddb52b7a8c80d0a67a08587e5d245cc9c553a74a847056bc2976b15"
  end

  resource "attrs" do
    url "https://files.pythonhosted.org/packages/21/31/3f468da74c7de4fcf9b25591e682856389b3400b4b62f201e65f15ea3e07/attrs-22.2.0.tar.gz"
    sha256 "c9227bfc2f01993c03f68db37d1d15c9690188323c067c641f1a35ca58185f99"
  end

  resource "bitstring" do
    url "https://files.pythonhosted.org/packages/d2/64/e733b18349be383a4b7859c865d6c9e5ccc5845e9b4258504055607ec1cb/bitstring-4.0.1.tar.gz"
    sha256 "7719f08f6df89ce28453a5e580d4a8ec1d1bda892dbb033466da0ccd9bdcb706"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/37/f7/2b1b0ec44fdc30a3d31dfebe52226be9ddc40cd6c0f34ffc8923ba423b69/certifi-2022.12.7.tar.gz"
    sha256 "35824b4c3a97115964b408844d64aa14db1cc518f6562e8d7261699d1350a9e3"
  end

  resource "cffi" do
    url "https://files.pythonhosted.org/packages/2b/a8/050ab4f0c3d4c1b8aaa805f70e26e84d0e27004907c5b8ecc1d31815f92a/cffi-1.15.1.tar.gz"
    sha256 "d400bfb9a37b1351253cb402671cea7e89bdecc294e8016a707f6d1d8ac934f9"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/a1/34/44964211e5410b051e4b8d2869c470ae8a68ae274953b1c7de6d98bbcf94/charset-normalizer-2.1.1.tar.gz"
    sha256 "5a3d016c7c547f69d6f81fb0db9449ce888b418b5b9952cc5e6e66843e9dd845"
  end

  resource "cryptography" do
    url "https://files.pythonhosted.org/packages/e3/3f/41186b1f2fd86a542d399175f6b8e43f82cd4dfa51235a0b030a042b811a/cryptography-38.0.4.tar.gz"
    sha256 "175c1a818b87c9ac80bb7377f5520b7f31b3ef2a0004e2420319beadedb67290"
  end

  resource "dnspython" do
    url "https://files.pythonhosted.org/packages/99/fb/e7cd35bba24295ad41abfdff30f6b4c271fd6ac70d20132fa503c3e768e0/dnspython-2.2.1.tar.gz"
    sha256 "0f7569a4a6ff151958b64304071d370daa3243d15941a7beedf0c9fe5105603e"
  end

  resource "frozenlist" do
    url "https://files.pythonhosted.org/packages/e9/10/d629476346112b85c912527b9080944fd2c39a816c2225413dbc0bb6fcc0/frozenlist-1.3.3.tar.gz"
    sha256 "58bcc55721e8a90b88332d6cd441261ebb22342e238296bb330968952fbb3a6a"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/8b/e1/43beb3d38dba6cb420cefa297822eac205a277ab43e5ba5d5c46faf96438/idna-3.4.tar.gz"
    sha256 "814f528e8dead7d329833b91c5faa87d60bf71824cd12a7530b5526063d02cb4"
  end

  resource "multidict" do
    url "https://files.pythonhosted.org/packages/4a/15/bd620f7a6eb9aa5112c4ef93e7031bcd071e0611763d8e17706ef8ba65e0/multidict-6.0.4.tar.gz"
    sha256 "3666906492efb76453c0e7b97f2cf459b0682e7402c0489a95484965dbc1da49"
  end

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/6b/f7/c240d7654ddd2d2f3f328d8468d4f1f876865f6b9038b146bec0a6737c65/packaging-22.0.tar.gz"
    sha256 "2198ec20bd4c017b8f9717e00f0c8714076fc2fd93816750ab48e2c41de2cfd3"
  end

  resource "protobuf" do
    url "https://files.pythonhosted.org/packages/55/5b/e3d951e34f8356e5feecacd12a8e3b258a1da6d9a03ad1770f28925f29bc/protobuf-3.20.3.tar.gz"
    sha256 "2e3427429c9cffebf259491be0af70189607f365c2f41c7c3764af6f337105f2"
  end

  resource "pycparser" do
    url "https://files.pythonhosted.org/packages/5e/0b/95d387f5f4433cb0f53ff7ad859bd2c6051051cebbb564f139a999ab46de/pycparser-2.21.tar.gz"
    sha256 "e644fdec12f7872f86c58ff790da456218b10f863970249516d60a5eaca77206"
  end

  resource "python-socks" do
    url "https://files.pythonhosted.org/packages/44/54/dc01d98b5eec803d1ce1c213ab1bad4cad41901bc929d93766f31cc1c9f9/python-socks-2.1.1.tar.gz"
    sha256 "3bb68964c97690d5a3eab6c12a772f415725f295b148cbe1ca8870cb47ebcb96"
  end

  resource "QDarkStyle" do
    url "https://files.pythonhosted.org/packages/1a/1c/00ca31b13727ade22d1b42b61dc86056493a72f01912082a61cb34e5abf6/QDarkStyle-3.1.tar.gz"
    sha256 "600584d625343e0ddd128de08393d3c35637786a49827f174d29aa7caa8279c1"
  end

  resource "qrcode" do
    url "https://files.pythonhosted.org/packages/94/9f/31f33cdf3cf8f98e64c42582fb82f39ca718264df61957f28b0bbb09b134/qrcode-7.3.1.tar.gz"
    sha256 "375a6ff240ca9bd41adc070428b5dfc1dcfbb0f2507f1ac848f6cded38956578"
  end

  resource "QtPy" do
    url "https://files.pythonhosted.org/packages/b0/96/4f3be023cee0261b1f6cd5d2f6c2a5abea8d8022fc66027da8792373a57e/QtPy-2.3.0.tar.gz"
    sha256 "0603c9c83ccc035a4717a12908bf6bc6cb22509827ea2ec0e94c2da7c9ed57c5"
  end

  resource "yarl" do
    url "https://files.pythonhosted.org/packages/c4/1e/1b204050c601d5cd82b45d5c8f439cb6f744a2ce0c0a6f83be0ddf0dc7b2/yarl-1.8.2.tar.gz"
    sha256 "49d43402c6e3013ad0978602bf6bf5328535c48d192304b91b97a3c6790b1562"
  end

  def install
    # https://stackoverflow.com/a/44466013
    ENV.delete("PYTHONPATH")

    xy = Language::Python.major_minor_version("python3")

    virtualenv_install_with_resources

    cp Dir[Formula["libsecp256k1"].opt_lib/"*"].select { |f| File.file? f },
       libexec/"lib/python#{xy}/site-packages/electrum/"

    # Electrum is hardcoded to expect a "libsecp256k1.0.dylib" library.
    cd libexec/"lib/python#{xy}/site-packages/electrum/" do
      inreplace "ecc_fast.py", "libsecp256k1.0.dylib", "libsecp256k1.1.dylib"
    end
  end

  test do
    system bin/"electrum", "--help"
  end
end
