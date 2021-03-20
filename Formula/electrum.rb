class Electrum < Formula
  include Language::Python::Virtualenv

  desc "Bitcoin thin client"
  homepage "https://electrum.org"
  url "https://download.electrum.org/4.0.9/Electrum-4.0.9.tar.gz"
  sha256 "6a3fc11aa475fa4d1573d72116eeddae43a495443d8bfcba15c3a1139f8a72bb"
  revision 1

  bottle do
    root_url "https://dl.bintray.com/domt4/crypto-bottles"
    cellar :any
    sha256 "a2ea2859738a0005468cedaeb65e087b8dba008ca60d90ddd604915c8c578fe7" => :big_sur
  end

  depends_on "cython" => :build
  # A little stunningly, cryptography now requires a whole Rust compiler to
  # build. We could use `CRYPTOGRAPHY_DONT_BUILD_RUST=1` but that seems to be
  # a hack rather than something upstream want to support indefinitely.
  depends_on "rust" => :build
  depends_on "pyqt@5" # Check contrib/requirements/requirements-binaries-mac.txt
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
    url "https://files.pythonhosted.org/packages/99/f5/90ede947a3ce2d6de1614799f5fea4e93c19b6520a59dc5d2f64123b032f/aiohttp-3.7.4.post0.tar.gz"
    sha256 "493d3299ebe5f5a7c66b9819eacdcfbbaaf1a8e84911ddffcdc48888497afecf"
  end

  resource "aiohttp-socks" do
    url "https://files.pythonhosted.org/packages/bc/ad/dbfeb2fe092a9bebabb3ff827c5c7e1301da2858169646814ae55e1d5017/aiohttp_socks-0.6.0.tar.gz"
    sha256 "b95dcfba3740c8499f4ff633846d72108459d25650ebc1ae8b299cb817088013"
  end

  resource "aiorpcX" do
    url "https://files.pythonhosted.org/packages/df/73/37fa55f77ccda7f9fd3cdfb120a97da7ca556929b5d6a0086fadbddf5747/aiorpcX-0.18.7.tar.gz"
    sha256 "808a9ec9172df11677a0f7b459b69d1a6cf8b19c19da55541fa31fb1afce5ce7"
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
    url "https://files.pythonhosted.org/packages/b5/c1/8e77d5389cf1ea2535049e5ffaeb241cce21bcc1c42624b3e8d0fb3bb607/base58-2.1.0.tar.gz"
    sha256 "171a547b4a3c61e1ae3807224a6f7aec75e364c4395e7562649d7335768001a2"
  end

  resource "bitbox02" do
    url "https://files.pythonhosted.org/packages/a7/92/9b467cdd1273deb4bc02f65e7f5dd5fb2fcb81e28ae78cbe6a1643fc5536/bitbox02-5.3.0.tar.gz"
    sha256 "fe0e8aeb9b32fd7d76bb3e9838895973a74dfd532a8fb8ac174a1a60214aee26"
  end

  resource "bitstring" do
    url "https://files.pythonhosted.org/packages/c3/fc/ffac2c199d2efe1ec5111f55efeb78f5f2972456df6939fea849f103f9f5/bitstring-3.1.7.tar.gz"
    sha256 "fdf3eb72b229d2864fb507f8f42b1b2c57af7ce5fec035972f9566de440a864a"
  end

  resource "btchip-python" do
    url "https://files.pythonhosted.org/packages/30/fd/16394adaff5736840aeda77163d5f6f593091d687a1807ff02dedcfc7bca/btchip-python-0.1.32.tar.gz"
    sha256 "34f5e0c161c08f65dc0d070ba2ff4c315ed21c4b7e0faa32a46862d0dc1b8f55"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/06/a9/cd1fd8ee13f73a4d4f491ee219deeeae20afefa914dfb4c130cfc9dc397a/certifi-2020.12.5.tar.gz"
    sha256 "1a4995114262bffbc2413b159f2a1a480c969de6e6eb13ee966d470af86af59c"
  end

  resource "cffi" do
    url "https://files.pythonhosted.org/packages/a8/20/025f59f929bbcaa579704f443a438135918484fffaacfaddba776b374563/cffi-1.14.5.tar.gz"
    sha256 "fd78e5fee591709f32ef6edb9a015b4aa1a5022598e36227500c8f4e02328d9c"
  end

  resource "chardet" do
    url "https://files.pythonhosted.org/packages/ee/2d/9cdc2b527e127b4c9db64b86647d567985940ac3698eeabc7ffaccb4ea61/chardet-4.0.0.tar.gz"
    sha256 "0d6f53a15db4120f2b08c94f11e7d93d2c911ee118b6b30a04ec3ee8310179fa"
  end

  resource "ckcc-protocol" do
    url "https://files.pythonhosted.org/packages/49/8e/82c3d27c019166967e4f604a4d727fc0ab5f763e85d56acb5297585203aa/ckcc-protocol-1.1.0.tar.gz"
    sha256 "b660225ac06fc06ad17b33ece428126eef785388450e14313f72d25d4082c5ab"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/27/6f/be940c8b1f1d69daceeb0032fee6c34d7bd70e3e649ccac0951500b4720e/click-7.1.2.tar.gz"
    sha256 "d2b5255c7c6349bc1bd1e59e08cd12acbbd63ce649f2588755783aa94dfb6b1a"
  end

  resource "construct" do
    url "https://files.pythonhosted.org/packages/13/92/517dd8f4b4f79d75a15b1c9c68e510cb323da0ff098f7ed62d2fdda525db/construct-2.10.61.tar.gz"
    sha256 "d75384a04cb36ae5417dd34ce230c392e6085d872ab8a99ebd756c34bac0dff5"
  end

  resource "cryptography" do
    url "https://files.pythonhosted.org/packages/fa/2d/2154d8cb773064570f48ec0b60258a4522490fcb115a6c7c9423482ca993/cryptography-3.4.6.tar.gz"
    sha256 "2d32223e5b0ee02943f32b19245b61a62db83a882f0e76cc564e1cec60d48f87"
  end

  resource "dnspython" do
    url "https://files.pythonhosted.org/packages/13/27/5277de856f605f3429d752a39af3588e29d10181a3aa2e2ee471d817485a/dnspython-2.1.0.zip"
    sha256 "e4a87f0b573201a0f3727fa18a516b055fd1107e0e5477cded4a2de497df1dd4"
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
    url "https://files.pythonhosted.org/packages/93/a5/9158cc348cb362a668ff3fa5d683cdceb44f4bb10792191636c15f6383cc/libusb1-1.9.2.tar.gz"
    sha256 "27aec6aa1ff9ca845d0035023f3cf39710afac56903c51cd96a95404d064189e"
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
    url "https://files.pythonhosted.org/packages/c5/82/cee5dcde1c7a0ffe1336946a117d31b1a394558fcf4d8ca3fba720a47f80/protobuf-3.15.6.tar.gz"
    sha256 "2b974519a2ae83aa1e31cff9018c70bbe0e303a46a598f982943c49ae1d4fcd3"
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
    url "https://files.pythonhosted.org/packages/7e/32/86c580f89a2702014460a008ccf1c819db44a388a4de4ef4155b6a9b4b7b/python-socks-1.2.2.tar.gz"
    sha256 "d76065797250edc4b773c205cfa3c4834301fdb27a650478d1d7396cafc533fa"
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
    url "https://files.pythonhosted.org/packages/cb/cf/871177f1fc795c6c10787bc0e1f27bb6cf7b81dbde399fd35860472cecbc/urllib3-1.26.4.tar.gz"
    sha256 "e7b021f7241115872f92f43c6508082facffbd1c048e3c6e2bb9c2a157e28937"
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
