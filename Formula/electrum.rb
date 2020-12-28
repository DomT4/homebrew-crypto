class Electrum < Formula
  include Language::Python::Virtualenv

  desc "Bitcoin thin client"
  homepage "https://electrum.org"
  url "https://download.electrum.org/4.0.9/Electrum-4.0.9.tar.gz"
  sha256 "6a3fc11aa475fa4d1573d72116eeddae43a495443d8bfcba15c3a1139f8a72bb"

  bottle do
    root_url "https://dl.bintray.com/domt4/crypto-bottles"
    cellar :any
    sha256 "a2ea2859738a0005468cedaeb65e087b8dba008ca60d90ddd604915c8c578fe7" => :big_sur
  end

  depends_on "cython" => :build
  depends_on "pyqt"
  depends_on "protobuf"
  depends_on "python"
  depends_on "secp256k1"

  # It's really annoying this is required because it makes the build *a lot*
  # slower than it would otherwise be. Need to look into this more to see if
  # it's possible to just go back to using the core pyqt Python bindings
  # without constantly hitting `ModuleNotFoundError: No module named 'PyQt5.sip'`.
  resource "PyQt5-sip" do
    url "https://files.pythonhosted.org/packages/73/8c/c662b7ebc4b2407d8679da68e11c2a2eb275f5f2242a92610f6e5024c1f2/PyQt5_sip-12.8.1.tar.gz"
    sha256 "30e944db9abee9cc757aea16906d4198129558533eb7fadbe48c5da2bd18e0bd"
  end
  # END of above notes.

  resource "QDarkStyle" do
    url "https://files.pythonhosted.org/packages/83/52/40111409358173b1013231638f58793a4f43f935b8419919b47846d5e0a6/QDarkStyle-2.8.1.tar.gz"
    sha256 "d53b0120bddd9e3efba9801731e22ef86ed798bb5fc6a802f5f7bb32dedf0321"
  end

  resource "QtPy" do
    url "https://files.pythonhosted.org/packages/af/9f/f92125f9ba07830e5dd99141d07d5edffd555670d2c16a8454ac4a65d27b/QtPy-1.9.0.tar.gz"
    sha256 "2db72c44b55d0fe1407be8fba35c838ad0d6d3bb81f23007886dc1fc0f459c8d"
  end

  resource "aiohttp" do
    url "https://files.pythonhosted.org/packages/68/96/40a765d7d68028c5a6d169b2747ea3f4828ec91a358a63818d468380521c/aiohttp-3.7.3.tar.gz"
    sha256 "9c1a81af067e72261c9cbe33ea792893e83bc6aa987bfbd6fdc1e5e7b22777c4"
  end

  resource "aiohttp-socks" do
    url "https://files.pythonhosted.org/packages/e8/14/27448875ae2475452cc6485ea51f36b45394041f1e1b588e977d8bb11fad/aiohttp_socks-0.5.5.tar.gz"
    sha256 "2eb2059756bde34c55bb429541cbf2eba3fd53e36ac80875b461221e2858b04a"
  end

  resource "aiorpcX" do
    url "https://files.pythonhosted.org/packages/81/fd/931795c7ffd19d4ace57d9997f0d848ad5c4d7a57e8af2705f88ad7364f9/aiorpcX-0.18.5.tar.gz"
    sha256 "18eba632833b3ac75bbf7db67b32920129670b91919d7f54aeed35c813e8357a"
  end

  resource "async-timeout" do
    url "https://files.pythonhosted.org/packages/a1/78/aae1545aba6e87e23ecab8d212b58bb70e72164b67eb090b81bb17ad38e3/async-timeout-3.0.1.tar.gz"
    sha256 "0c3c816a028d47f659d6ff5c745cb2acf1f966da1fe5c19c77a70282b25f4c5f"
  end

  resource "attrs" do
    url "https://files.pythonhosted.org/packages/f0/cb/80a4a274df7da7b8baf083249b0890a0579374c3d74b5ac0ee9291f912dc/attrs-20.3.0.tar.gz"
    sha256 "832aa3cde19744e49938b91fea06d69ecb9e649c93ba974535d08ad92164f700"
  end

  resource "base58" do
    url "https://files.pythonhosted.org/packages/66/0c/44d075d9b07bb25c4733421057a46fe1847e9c64286e8af11458815ff872/base58-2.0.1.tar.gz"
    sha256 "365c9561d9babac1b5f18ee797508cd54937a724b6e419a130abad69cec5ca79"
  end

  resource "bitbox02" do
    url "https://files.pythonhosted.org/packages/07/e5/6052fae79fed77bdeb88932a1773e2d7476a9bf84531ecf7b0a9c889c869/bitbox02-5.1.0.tar.gz"
    sha256 "0562bc93d87afd89879e130c60c8dbfaffa8a1c3deff01201702939c9594d242"
  end

  resource "bitstring" do
    url "https://files.pythonhosted.org/packages/c3/fc/ffac2c199d2efe1ec5111f55efeb78f5f2972456df6939fea849f103f9f5/bitstring-3.1.7.tar.gz"
    sha256 "fdf3eb72b229d2864fb507f8f42b1b2c57af7ce5fec035972f9566de440a864a"
  end

  resource "btchip-python" do
    url "https://files.pythonhosted.org/packages/54/84/3060eb0f953bf90f7477b8838662170fab841fda4d17ffd9e6e58dd2d1d4/btchip-python-0.1.31.tar.gz"
    sha256 "4167f3c6ea832dd189d447d0d7a8c2a968027671ae6f43c680192f2b72c39b2c"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/06/a9/cd1fd8ee13f73a4d4f491ee219deeeae20afefa914dfb4c130cfc9dc397a/certifi-2020.12.5.tar.gz"
    sha256 "1a4995114262bffbc2413b159f2a1a480c969de6e6eb13ee966d470af86af59c"
  end

  resource "cffi" do
    url "https://files.pythonhosted.org/packages/66/6a/98e023b3d11537a5521902ac6b50db470c826c682be6a8c661549cb7717a/cffi-1.14.4.tar.gz"
    sha256 "1a465cbe98a7fd391d47dce4b8f7e5b921e6cd805ef421d04f5f66ba8f06086c"
  end

  resource "chardet" do
    url "https://files.pythonhosted.org/packages/fc/bb/a5768c230f9ddb03acc9ef3f0d4a3cf93462473795d18e9535498c8f929d/chardet-3.0.4.tar.gz"
    sha256 "84ab92ed1c4d4f16916e05906b6b75a6c0fb5db821cc65e70cbd64a3e2a5eaae"
  end

  resource "ckcc-protocol" do
    url "https://files.pythonhosted.org/packages/61/f0/7ae03ef46ff4c5f185ff36030491e273d3ba5bd342ec5b3f08cd07e3a74f/ckcc-protocol-1.0.2.tar.gz"
    sha256 "31c01e4e460b949d6a570501996c54ee17f5ea25c1ec70b4e1535fe5631df67e"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/27/6f/be940c8b1f1d69daceeb0032fee6c34d7bd70e3e649ccac0951500b4720e/click-7.1.2.tar.gz"
    sha256 "d2b5255c7c6349bc1bd1e59e08cd12acbbd63ce649f2588755783aa94dfb6b1a"
  end

  resource "construct" do
    url "https://files.pythonhosted.org/packages/00/e0/71e41b817220333c7c511c3f78d988d69f9b03b5cca2f251a898ad3567a3/construct-2.10.56.tar.gz"
    sha256 "97ba13edcd98546f10f7555af41c8ce7ae9d8221525ec4062c03f9adbf940661"
  end

  resource "cryptography" do
    url "https://files.pythonhosted.org/packages/b7/82/f7a4ddc1af185936c1e4fa000942ffa8fb2d98cff26b75afa7b3c63391c4/cryptography-3.3.1.tar.gz"
    sha256 "7e177e4bea2de937a584b13645cab32f25e3d96fc0bc4a4cf99c27dc77682be6"
  end

  resource "dnspython" do
    url "https://files.pythonhosted.org/packages/67/d0/639a9b5273103a18c5c68a7a9fc02b01cffa3403e72d553acec444f85d5b/dnspython-2.0.0.zip"
    sha256 "044af09374469c3a39eeea1a146e8cac27daec951f1f1f157b1962fc7cb9d1b7"
  end

  resource "ecdsa" do
    url "https://files.pythonhosted.org/packages/1d/d4/0684a83b3c16a9d1446ace27a506cef1db9b23984ac7ed6aaf764fdd56e8/ecdsa-0.16.1.tar.gz"
    sha256 "cfc046a2ddd425adbd1a78b3c46f0d1325c657811c0f45ecc3a0a6236c1e50ff"
  end

  resource "helpdev" do
    url "https://files.pythonhosted.org/packages/16/8d/1909747368fef0cda0af1c570be578deff1f4fc3512c1e308c8fff73f359/helpdev-0.7.1.tar.gz"
    sha256 "bb62a79acbac141dadf42cadeb92bb7450dd18b9824a62043b6a0b149190db3d"
  end

  resource "hidapi" do
    url "https://files.pythonhosted.org/packages/99/9b/5c41756461308a5b2d8dcbcd6eaa2f1c1bc60f0a6aa743b58cab756a92e1/hidapi-0.10.1.tar.gz"
    sha256 "a1170b18050bc57fae3840a51084e8252fd319c0fc6043d68c8501deb0e25846"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/ea/b7/e0e3c1c467636186c39925827be42f16fee389dc404ac29e930e9136be70/idna-2.10.tar.gz"
    sha256 "b307872f855b18632ce0c21c5e45be78c0ea7ae4c15c828c20788b26921eb3f6"
  end

  resource "keepkey" do
    url "https://files.pythonhosted.org/packages/30/38/558d9a2dd1fd74f50ff4587b4054496ffb69e21ab1138eb448f3e8e2f4a7/keepkey-6.3.1.tar.gz"
    sha256 "cef1e862e195ece3e42640a0f57d15a63086fd1dedc8b5ddfcbc9c2657f0bb1e"
  end

  resource "libusb1" do
    url "https://files.pythonhosted.org/packages/04/0f/747b168750575bf5a902e871cf3e732ab01155ee64ed383d5f06d8b961bc/libusb1-1.9.1.tar.gz"
    sha256 "d03ef15248c8b8ce440f6be4248eaadc074fc2dc5edd36c48e6e78eef3999292"
  end

  resource "mnemonic" do
    url "https://files.pythonhosted.org/packages/80/0d/63de5efd5585fd6eb79eb35d3feb91deee8003e60997d61e3759eaf1ea66/mnemonic-0.19.tar.gz"
    sha256 "4e37eb02b2cbd56a0079cabe58a6da93e60e3e4d6e757a586d9f23d96abea931"
  end

  resource "multidict" do
    url "https://files.pythonhosted.org/packages/1c/74/e8b46156f37ca56d10d895d4e8595aa2b344cff3c1fb3629ec97a8656ccb/multidict-5.1.0.tar.gz"
    sha256 "25b4e5f22d3a37ddf3effc0710ba692cfc792c2b9edfb9c05aefe823256e84d5"
  end

  resource "noiseprotocol" do
    url "https://files.pythonhosted.org/packages/76/17/fcf8a90dcf36fe00b475e395f34d92f42c41379c77b25a16066f63002f95/noiseprotocol-0.3.1.tar.gz"
    sha256 "b092a871b60f6a8f07f17950dc9f7098c8fe7d715b049bd4c24ee3752b90d645"
  end

  resource "protobuf" do
    url "https://files.pythonhosted.org/packages/12/ba/d6d9f1432663ab5623f761c86be11e7f2f6fb28348612f48fb082d3cfcea/protobuf-3.14.0.tar.gz"
    sha256 "1d63eb389347293d8915fb47bee0951c7b5dab522a4a60118b9a18f33e21f8ce"
  end

  resource "pyaes" do
    url "https://files.pythonhosted.org/packages/44/66/2c17bae31c906613795711fc78045c285048168919ace2220daa372c7d72/pyaes-1.6.1.tar.gz"
    sha256 "02c1b1405c38d3c370b085fb952dd8bea3fadcee6411ad99f312cc129c536d8f"
  end

  resource "pycparser" do
    url "https://files.pythonhosted.org/packages/0f/86/e19659527668d70be91d0369aeaa055b4eb396b0f387a4f92293a20035bd/pycparser-2.20.tar.gz"
    sha256 "2d475327684562c3a96cc71adf7dc8c4f0565175cf86b6d7a404ff4c771f15f0"
  end

  resource "python-socks" do
    url "https://files.pythonhosted.org/packages/c0/15/8acf4a45d009fbf750690f4f3093afa796625456ebc320c79e2caa643425/python-socks-1.1.2.tar.gz"
    sha256 "fa7513c9293d95d90b1da9e10b84fa53afcb4c0f67e9c141d9f479cde2d8af1a"
  end

  resource "qrcode" do
    url "https://files.pythonhosted.org/packages/19/d5/6c7d4e103d94364d067636417a77a6024219c58cd6e9f428ece9b5061ef9/qrcode-6.1.tar.gz"
    sha256 "505253854f607f2abf4d16092c61d4e9d511a3b4392e60bff957a68592b04369"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/6b/47/c14abc08432ab22dc18b9892252efaf005ab44066de871e72a38d6af464b/requests-2.25.1.tar.gz"
    sha256 "27973dd4a904a4f13b263a19c866c13b92a39ed1c964655f025f3f8d3d75b804"
  end

  resource "safet" do
    url "https://files.pythonhosted.org/packages/88/22/f0cd0821c744b9b72af17a8e7af0c8b23baed60ffa56b58e3bdc3b233f7e/safet-0.1.5.tar.gz"
    sha256 "a7fd4b68bb1bc6185298af665c8e8e00e2bb2bcbddbb22844ead929b845c635e"
  end

  resource "semver" do
    url "https://files.pythonhosted.org/packages/31/a9/b61190916030ee9af83de342e101f192bbb436c59be20a4cb0cdb7256ece/semver-2.13.0.tar.gz"
    sha256 "fa0fe2722ee1c3f57eac478820c3a5ae2f624af8264cbdf9000c980ff7f75e3f"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/6b/34/415834bfdafca3c5f451532e8a8d9ba89a21c9743a0c59fbd0205c7f9426/six-1.15.0.tar.gz"
    sha256 "30639c035cdb23534cd4aa2dd52c3bf48f06e5f4a941509c8bafd8ce11080259"
  end

  resource "trezor" do
    url "https://files.pythonhosted.org/packages/40/bb/e5aff94fb22fcce0b57dd773b5fd1e8b7bdd16c4bc982755984b9a09bb7d/trezor-0.12.2.tar.gz"
    sha256 "5bd226b829e5f6ad6c7263f5303f58b54e07b0f21263c4b8ba57981881071264"
  end

  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/16/06/0f7367eafb692f73158e5c5cbca1aec798cdf78be5167f6415dd4205fa32/typing_extensions-3.7.4.3.tar.gz"
    sha256 "99d4073b617d30288f569d3f13d2bd7548c3a7e4c8de87db09a9d29bb3a4a60c"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/29/e6/d1a1d78c439cad688757b70f26c50a53332167c364edb0134cadd280e234/urllib3-1.26.2.tar.gz"
    sha256 "19188f96923873c92ccb987120ec4acaa12f0461fa9ce5d3d0772bc965a39e08"
  end

  resource "yarl" do
    url "https://files.pythonhosted.org/packages/97/e7/af7219a0fe240e8ef6bb555341a63c43045c21ab0392b4435e754b716fa1/yarl-1.6.3.tar.gz"
    sha256 "8a9066529240171b68893d60dca86a763eae2139dd42f42106b03cf4b426bf10"
  end

  def install
    # https://stackoverflow.com/a/44466013
    ENV.delete("PYTHONPATH")

    virtualenv_install_with_resources
  end

  test do
    system bin/"electrum", "--help"
  end
end
