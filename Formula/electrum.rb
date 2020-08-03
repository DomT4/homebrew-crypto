class Electrum < Formula
  include Language::Python::Virtualenv

  desc "Bitcoin thin client"
  homepage "https://electrum.org"
  url "https://download.electrum.org/4.0.2/Electrum-4.0.2.tar.gz"
  sha256 "810bff7b0bb6b2d1da4d4a6421b94cc5b493fdeeb0c61b34b3ce38ed4dce2b16"

  depends_on "cython" => :build
  depends_on "pyqt"
  depends_on "protobuf"
  depends_on "python@3.8" # This can be changed back to python at some point.
  depends_on "secp256k1"

  # It's really annoying this is required because it makes the build *a lot*
  # slower than it would otherwise be. Need to look into this more to see if
  # it's possible to just go back to using the core pyqt Python bindings
  # without constantly hitting `ModuleNotFoundError: No module named 'PyQt5.sip'`.
  resource "PyQt5-sip" do
    url "https://files.pythonhosted.org/packages/73/a0/0987d3c153b18fd5f7b190bdc71e8edd05ff65e9084efd1f4985c2b1dc0f/PyQt5_sip-12.8.0.tar.gz"
    sha256 "0a34b6596bdd28d52da3a51fa8d9bb0b287bcb605c2512aa3251b9028cc71f4d"
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
    url "https://files.pythonhosted.org/packages/00/94/f9fa18e8d7124d7850a5715a0b9c0584f7b9375d331d35e157cee50f27cc/aiohttp-3.6.2.tar.gz"
    sha256 "259ab809ff0727d0e834ac5e8a283dc5e3e0ecc30c4d80b3cd17a4139ce1f326"
  end

  resource "aiohttp-socks" do
    url "https://files.pythonhosted.org/packages/21/32/afa61fac464cf56ae668c3a45ea797e4e8d97bd4ec1088ef41317efac302/aiohttp_socks-0.5.3.tar.gz"
    sha256 "f2f3f6979d7427207044d7127be1a5de412e9186d5f9ac05fdb688a239351652"
  end

  resource "aiorpcX" do
    url "https://files.pythonhosted.org/packages/62/90/0c181e61238d2ab58679f34f351fee98c965716884ccd9f84fedc7d3d0e1/aiorpcX-0.18.4.tar.gz"
    sha256 "bec9c0feb328d62ba80b79931b07f7372c98f2891ad51300be0b7163d5ccfb4a"
  end

  resource "async-timeout" do
    url "https://files.pythonhosted.org/packages/a1/78/aae1545aba6e87e23ecab8d212b58bb70e72164b67eb090b81bb17ad38e3/async-timeout-3.0.1.tar.gz"
    sha256 "0c3c816a028d47f659d6ff5c745cb2acf1f966da1fe5c19c77a70282b25f4c5f"
  end

  resource "attrs" do
    url "https://files.pythonhosted.org/packages/98/c3/2c227e66b5e896e15ccdae2e00bbc69aa46e9a8ce8869cc5fa96310bf612/attrs-19.3.0.tar.gz"
    sha256 "f7b7ce16570fe9965acd6d30101a28f62fb4a7f9e926b3bbc9b61f8b04247e72"
  end

  resource "base58" do
    url "https://files.pythonhosted.org/packages/66/0c/44d075d9b07bb25c4733421057a46fe1847e9c64286e8af11458815ff872/base58-2.0.1.tar.gz"
    sha256 "365c9561d9babac1b5f18ee797508cd54937a724b6e419a130abad69cec5ca79"
  end

  resource "bitbox02" do
    url "https://files.pythonhosted.org/packages/d3/ca/29ba8c94fe0e67ea8a72661a818f5c2f154c32da0f2e828c8bd14ba805c4/bitbox02-4.1.0.tar.gz"
    sha256 "73a35594162f32897dd2b1880f0cfaa42922acd1c2d7f4cf3d94b8333329c931"
  end

  resource "bitstring" do
    url "https://files.pythonhosted.org/packages/c3/fc/ffac2c199d2efe1ec5111f55efeb78f5f2972456df6939fea849f103f9f5/bitstring-3.1.7.tar.gz"
    sha256 "fdf3eb72b229d2864fb507f8f42b1b2c57af7ce5fec035972f9566de440a864a"
  end

  resource "btchip-python" do
    url "https://files.pythonhosted.org/packages/a9/20/1eeda466e982965cab498aed7a624e16cadbca719be83603443ba582ce21/btchip-python-0.1.30.tar.gz"
    sha256 "6869c67a712969ae86af23617f6418049076626f8a8c34d1000b1c58a9702ad7"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/40/a7/ded59fa294b85ca206082306bba75469a38ea1c7d44ea7e1d64f5443d67a/certifi-2020.6.20.tar.gz"
    sha256 "5930595817496dd21bb8dc35dad090f1c2cd0adfaf21204bf6732ca5d8ee34d3"
  end

  resource "cffi" do
    url "https://files.pythonhosted.org/packages/54/1d/15eae71ab444bd88a1d69f19592dcf32b9e3166ecf427dd9243ef0d3b7bc/cffi-1.14.1.tar.gz"
    sha256 "b2a2b0d276a136146e012154baefaea2758ef1f56ae9f4e01c612b0831e0bd2f"
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
    url "https://files.pythonhosted.org/packages/bf/ac/552fc8729d90393845cc3a2062facf4a89dcbe206fa78771d60ddaae7554/cryptography-3.0.tar.gz"
    sha256 "8e924dbc025206e97756e8903039662aa58aa9ba357d8e1d8fc29e3092322053"
  end

  resource "dnspython" do
    url "https://files.pythonhosted.org/packages/ec/c5/14bcd63cb6d06092a004793399ec395405edf97c2301dfdc146dfbd5beed/dnspython-1.16.0.zip"
    sha256 "36c5e8e38d4369a08b6780b7f27d790a292b2b08eea01607865bf0936c558e01"
  end

  resource "ecdsa" do
    url "https://files.pythonhosted.org/packages/e3/7c/b508ade1feb47cd79222e06d85e477f5cfc4fb0455ad3c70eb6330fc49aa/ecdsa-0.15.tar.gz"
    sha256 "8f12ac317f8a1318efa75757ef0a651abe12e51fc1af8838fb91079445227277"
  end

  resource "helpdev" do
    url "https://files.pythonhosted.org/packages/16/8d/1909747368fef0cda0af1c570be578deff1f4fc3512c1e308c8fff73f359/helpdev-0.7.1.tar.gz"
    sha256 "bb62a79acbac141dadf42cadeb92bb7450dd18b9824a62043b6a0b149190db3d"
  end

  resource "hidapi" do
    url "https://files.pythonhosted.org/packages/ee/e9/b2ec08690c280a0eaa4777bf829db6b5d269903d4e8e9ce82f079c837d5a/hidapi-0.9.0.post3.tar.gz"
    sha256 "5a2442928f17ba742d9c53073f48b152051c5747d758d2fefd937543da5ab2e5"
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
    url "https://files.pythonhosted.org/packages/27/5c/4d1ebbcfb19071832ac9b4e4674435f4a33e34b8d5186d4aac9ff374f83c/libusb1-1.8.tar.gz"
    sha256 "240f65ac70ba3fab77749ec84a412e4e89624804cb80d6c9d394eef5af8878d6"
  end

  resource "mnemonic" do
    url "https://files.pythonhosted.org/packages/80/0d/63de5efd5585fd6eb79eb35d3feb91deee8003e60997d61e3759eaf1ea66/mnemonic-0.19.tar.gz"
    sha256 "4e37eb02b2cbd56a0079cabe58a6da93e60e3e4d6e757a586d9f23d96abea931"
  end

  resource "multidict" do
    url "https://files.pythonhosted.org/packages/65/d4/fabdcc5ee4451c8a8e177e27ddfd131a53a82ecc5a3b68468b7e9f8d70b4/multidict-4.7.6.tar.gz"
    sha256 "fbb77a75e529021e7c4a8d4e823d88ef4d23674a202be4f5addffc72cbb91430"
  end

  resource "noiseprotocol" do
    url "https://files.pythonhosted.org/packages/a7/4c/2e45c4aa9c1f8055e8b11f327dbf5b125cd0bf60a3c2881dd420c1d01f69/noiseprotocol-0.3.0.tar.gz"
    sha256 "81152e93910ac10ab392492a68dd6d8b1549f2d6fec7f85776f3119665f29809"
  end

  resource "protobuf" do
    url "https://files.pythonhosted.org/packages/5f/8b/533bafcdd7f68f4a21f0371ba1f1d3a3c6de28c1a22bf58b75bea1de8ef4/protobuf-3.12.4.tar.gz"
    sha256 "c99e5aea75b6f2b29c8d8da5bdc5f5ed8d9a5b4f15115c8316a3f0a850f94656"
  end

  resource "pyaes" do
    url "https://files.pythonhosted.org/packages/44/66/2c17bae31c906613795711fc78045c285048168919ace2220daa372c7d72/pyaes-1.6.1.tar.gz"
    sha256 "02c1b1405c38d3c370b085fb952dd8bea3fadcee6411ad99f312cc129c536d8f"
  end

  resource "pycparser" do
    url "https://files.pythonhosted.org/packages/0f/86/e19659527668d70be91d0369aeaa055b4eb396b0f387a4f92293a20035bd/pycparser-2.20.tar.gz"
    sha256 "2d475327684562c3a96cc71adf7dc8c4f0565175cf86b6d7a404ff4c771f15f0"
  end

  resource "qrcode" do
    url "https://files.pythonhosted.org/packages/19/d5/6c7d4e103d94364d067636417a77a6024219c58cd6e9f428ece9b5061ef9/qrcode-6.1.tar.gz"
    sha256 "505253854f607f2abf4d16092c61d4e9d511a3b4392e60bff957a68592b04369"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/da/67/672b422d9daf07365259958912ba533a0ecab839d4084c487a5fe9a5405f/requests-2.24.0.tar.gz"
    sha256 "b3559a131db72c33ee969480840fff4bb6dd111de7dd27c8ee1f820f4f00231b"
  end

  resource "safet" do
    url "https://files.pythonhosted.org/packages/88/22/f0cd0821c744b9b72af17a8e7af0c8b23baed60ffa56b58e3bdc3b233f7e/safet-0.1.5.tar.gz"
    sha256 "a7fd4b68bb1bc6185298af665c8e8e00e2bb2bcbddbb22844ead929b845c635e"
  end

  resource "semver" do
    url "https://files.pythonhosted.org/packages/aa/e8/cb894f70a52887f001aff5f264f68272c21fa58268495aca17df396c161f/semver-2.10.2.tar.gz"
    sha256 "c0a4a9d1e45557297a722ee9bac3de2ec2ea79016b6ffcaca609b0bc62cf4276"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/6b/34/415834bfdafca3c5f451532e8a8d9ba89a21c9743a0c59fbd0205c7f9426/six-1.15.0.tar.gz"
    sha256 "30639c035cdb23534cd4aa2dd52c3bf48f06e5f4a941509c8bafd8ce11080259"
  end

  resource "trezor" do
    url "https://files.pythonhosted.org/packages/d1/8d/f467c7a01f858a668940aadd160cee78505025a6ae73fa8bb3d685a45e2c/trezor-0.12.0.tar.gz"
    sha256 "f6bc821bddec06e67a1abd0be1d9fbc61c59b08272c736522ae2f6b225bf9579"
  end

  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/6a/28/d32852f2af6b5ead85d396249d5bdf450833f3a69896d76eb480d9c5e406/typing_extensions-3.7.4.2.tar.gz"
    sha256 "79ee589a3caca649a9bfd2a8de4709837400dfa00b6cc81962a1e6a1815969ae"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/81/f4/87467aeb3afc4a6056e1fe86626d259ab97e1213b1dfec14c7cb5f538bf0/urllib3-1.25.10.tar.gz"
    sha256 "91056c15fa70756691db97756772bb1eb9678fa585d9184f24534b100dc60f4a"
  end

  resource "yarl" do
    url "https://files.pythonhosted.org/packages/ac/dd/59768bb3fa08e8b23e91575bca3ff8d2edbfbceebec8c59eaa24c4215791/yarl-1.5.1.tar.gz"
    sha256 "c22c75b5f394f3d47105045ea551e08a3e804dc7e01b37800ca35b58f856c3d6"
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
