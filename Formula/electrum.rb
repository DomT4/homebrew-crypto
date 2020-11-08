class Electrum < Formula
  include Language::Python::Virtualenv

  desc "Bitcoin thin client"
  homepage "https://electrum.org"
  url "https://download.electrum.org/4.0.4/Electrum-4.0.4.tar.gz"
  sha256 "bb56e1770c2022e70f885e48f42c64927e61bdc38b925daa8e1a85fbb82cac0d"

  depends_on "cython" => :build
  depends_on "pyqt"
  depends_on "protobuf"
  depends_on "python@3.9" # This can be changed back to python at some point.
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
    url "https://files.pythonhosted.org/packages/4f/b7/a382cf8440d9edfdf2c0125a1b4ad6954caf1d786225b2dede99b60f5ab2/aiohttp-3.7.2.tar.gz"
    sha256 "c6da1af59841e6d43255d386a2c4bfb59c0a3b262bdb24325cc969d211be6070"
  end

  resource "aiohttp-socks" do
    url "https://files.pythonhosted.org/packages/e8/14/27448875ae2475452cc6485ea51f36b45394041f1e1b588e977d8bb11fad/aiohttp_socks-0.5.5.tar.gz"
    sha256 "2eb2059756bde34c55bb429541cbf2eba3fd53e36ac80875b461221e2858b04a"
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
    url "https://files.pythonhosted.org/packages/f0/cb/80a4a274df7da7b8baf083249b0890a0579374c3d74b5ac0ee9291f912dc/attrs-20.3.0.tar.gz"
    sha256 "832aa3cde19744e49938b91fea06d69ecb9e649c93ba974535d08ad92164f700"
  end

  resource "base58" do
    url "https://files.pythonhosted.org/packages/66/0c/44d075d9b07bb25c4733421057a46fe1847e9c64286e8af11458815ff872/base58-2.0.1.tar.gz"
    sha256 "365c9561d9babac1b5f18ee797508cd54937a724b6e419a130abad69cec5ca79"
  end

  resource "bitbox02" do
    url "https://files.pythonhosted.org/packages/cb/72/15244df247bdfb32083cdf3a5d36cdb7dbaa170e59a5af363ee8eeba3309/bitbox02-5.0.0.tar.gz"
    sha256 "97b43b97c9d59e2d0ba1b20894d0b83cf804c86c1464f7918f268ca72f0adc7b"
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
    url "https://files.pythonhosted.org/packages/40/a7/ded59fa294b85ca206082306bba75469a38ea1c7d44ea7e1d64f5443d67a/certifi-2020.6.20.tar.gz"
    sha256 "5930595817496dd21bb8dc35dad090f1c2cd0adfaf21204bf6732ca5d8ee34d3"
  end

  resource "cffi" do
    url "https://files.pythonhosted.org/packages/cb/ae/380e33d621ae301770358eb11a896a34c34f30db188847a561e8e39ee866/cffi-1.14.3.tar.gz"
    sha256 "f92f789e4f9241cd262ad7a555ca2c648a98178a953af117ef7fad46aa1d5591"
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
    url "https://files.pythonhosted.org/packages/94/5c/42de91c7fbdb817b2d9a4e64b067946eb38a4eb36c1a09c96c87a0f86a82/cryptography-3.2.1.tar.gz"
    sha256 "d3d5e10be0cf2a12214ddee45c6bd203dab435e3d83b4560c03066eda600bfe3"
  end

  resource "dnspython" do
    url "https://files.pythonhosted.org/packages/ec/c5/14bcd63cb6d06092a004793399ec395405edf97c2301dfdc146dfbd5beed/dnspython-1.16.0.zip"
    sha256 "36c5e8e38d4369a08b6780b7f27d790a292b2b08eea01607865bf0936c558e01"
  end

  resource "ecdsa" do
    url "https://files.pythonhosted.org/packages/23/c3/81b0040f2976775d6685c3bb3748355bb2b725a9210a4ea50afc5a90e7d9/ecdsa-0.16.0.tar.gz"
    sha256 "494c6a853e9ed2e9be33d160b41d47afc50a6629b993d2b9c5ad7bb226add892"
  end

  resource "helpdev" do
    url "https://files.pythonhosted.org/packages/16/8d/1909747368fef0cda0af1c570be578deff1f4fc3512c1e308c8fff73f359/helpdev-0.7.1.tar.gz"
    sha256 "bb62a79acbac141dadf42cadeb92bb7450dd18b9824a62043b6a0b149190db3d"
  end

  resource "hidapi" do
    url "https://files.pythonhosted.org/packages/52/4b/0d0fac70bd0a04949113a9ca50ba7b2344f547b9d85b0e7e5eded19d7d50/hidapi-0.10.0.post1.tar.gz"
    sha256 "27c04d42a7187becf7a8309d4846aa4f235ac8b7dafd758335b109f5cbd3b962"
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
    url "https://files.pythonhosted.org/packages/d2/5a/e95b0f9ebacd42e094e229a9a0a9e44d02876abf64969d0cb07dadcf3c4a/multidict-5.0.0.tar.gz"
    sha256 "1b324444299c3a49b601b1bf621fc21704e29066f6ac2b7d7e4034a4a18662a1"
  end

  resource "noiseprotocol" do
    url "https://files.pythonhosted.org/packages/a7/4c/2e45c4aa9c1f8055e8b11f327dbf5b125cd0bf60a3c2881dd420c1d01f69/noiseprotocol-0.3.0.tar.gz"
    sha256 "81152e93910ac10ab392492a68dd6d8b1549f2d6fec7f85776f3119665f29809"
  end

  resource "protobuf" do
    url "https://files.pythonhosted.org/packages/25/ef/8f36bc7e4c3dcad241a9e7a51520d30712a7abc034343bed841ff4ea3289/protobuf-3.13.0.tar.gz"
    sha256 "6a82e0c8bb2bf58f606040cc5814e07715b2094caeba281e2e7d0b0e2e397db5"
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
    url "https://files.pythonhosted.org/packages/03/ca/57fe5ce042a5606dfb74e8ed0db1970905026fe4e3731b55061795180aa4/python-socks-1.1.0.tar.gz"
    sha256 "3b4e2aaa0d616b02e432470bdc1106eb734c6640da34e47efdd429693e6daff0"
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
    url "https://files.pythonhosted.org/packages/76/d9/bbbafc76b18da706451fa91bc2ebe21c0daf8868ef3c30b869ac7cb7f01d/urllib3-1.25.11.tar.gz"
    sha256 "8d7eaa5a82a1cac232164990f04874c594c9453ec55eef02eab885aa02fc17a2"
  end

  resource "yarl" do
    url "https://files.pythonhosted.org/packages/6d/0b/44006eb5b3b7898e54df4b7481839d22d15cf3fc4f0420394ad9e3bb214e/yarl-1.6.2.tar.gz"
    sha256 "c45b49b59a5724869899798e1bbd447ac486215269511d3b76b4c235a1b766b6"
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
