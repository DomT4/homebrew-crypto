class Electrum < Formula
  include Language::Python::Virtualenv

  desc "Bitcoin thin client"
  homepage "https://electrum.org"
  url "https://download.electrum.org/3.3.4/Electrum-3.3.4.tar.gz"
  sha256 "2f230e85bcc5833315a44959c645d05df6694847a4ad8f7fe91c974f27472240"

  bottle do
    root_url "https://dl.bintray.com/domt4/crypto-bottles"
    cellar :any_skip_relocation
    sha256 "a5e513ac7a4214993ab1c9c720826b12f982a8087220246a62a3b7fdd5e0253c" => :mojave
  end

  depends_on "protobuf"
  depends_on "python"

  resource "Cython" do
    url "https://files.pythonhosted.org/packages/36/da/fcb979fc8cb486a67a013d6aefefbb95a3e19e67e49dff8a35e014046c5e/Cython-0.29.6.tar.gz"
    sha256 "6c5d33f1b5c864382fbce810a8fd9e015447869ae42e98e6301e977b8165e7ae"
  end

  resource "QDarkStyle" do
    url "https://files.pythonhosted.org/packages/2a/a1/6d3f940e479d6a7f5be32d0dcec67088857e98ae3e135bb7e72b60175c78/QDarkStyle-2.5.4.tar.gz"
    sha256 "3eb60922b8c4d9cedecb6897ca4c9f8a259d81bdefe5791976ccdf12432de1f0"
  end

  resource "aiohttp" do
    url "https://files.pythonhosted.org/packages/0f/58/c8b83f999da3b13e66249ea32f325be923791c0c10aee6cf16002a3effc1/aiohttp-3.5.4.tar.gz"
    sha256 "9c4c83f4fa1938377da32bc2d59379025ceeee8e24b89f72fcbccd8ca22dc9bf"
  end

  resource "aiohttp-socks" do
    url "https://files.pythonhosted.org/packages/c2/78/3cf7de8bcb047e1969d6b49d7ea50ef4d8254b3f1512721e425ad94ec1c0/aiohttp_socks-0.2.2.tar.gz"
    sha256 "eebd8939a7c3c1e3e7e1b2552c60039b4c65ef6b8b2351efcbdd98290538e310"
  end

  resource "aiorpcX" do
    url "https://files.pythonhosted.org/packages/bc/05/a7ff482cf131fdc52f512f598ea2bf4e0ebb133ff91c1f039b8ff8140bae/aiorpcX-0.10.5.tar.gz"
    sha256 "21add307084497c19c911d369f9e995c7cd9bd0ef74485cb5509682080559330"
  end

  resource "async_timeout" do
    url "https://files.pythonhosted.org/packages/a1/78/aae1545aba6e87e23ecab8d212b58bb70e72164b67eb090b81bb17ad38e3/async-timeout-3.0.1.tar.gz"
    sha256 "0c3c816a028d47f659d6ff5c745cb2acf1f966da1fe5c19c77a70282b25f4c5f"
  end

  resource "attrs" do
    url "https://files.pythonhosted.org/packages/cc/d9/931a24cc5394f19383fbbe3e1147a0291276afa43a0dc3ed0d6cd9fda813/attrs-19.1.0.tar.gz"
    sha256 "f0b870f674851ecbfbbbd364d6b5cbdff9dcedbc7f3f5e18a6891057f21fe399"
  end

  resource "btchip-python" do
    url "https://files.pythonhosted.org/packages/66/26/52b88daa03da39cc8d7178f945af0dcbba46d642ced6ea56e305762568ae/btchip-python-0.1.28.tar.gz"
    sha256 "da09d0d7a6180d428833795ea9a233c3b317ddfcccea8cc6f0eba59435e5dd83"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/06/b8/d1ea38513c22e8c906275d135818fee16ad8495985956a9b7e2bb21942a1/certifi-2019.3.9.tar.gz"
    sha256 "b26104d6835d1f5e49452a26eb2ff87fe7090b89dfcaee5ea2212697e1e1d7ae"
  end

  resource "chardet" do
    url "https://files.pythonhosted.org/packages/fc/bb/a5768c230f9ddb03acc9ef3f0d4a3cf93462473795d18e9535498c8f929d/chardet-3.0.4.tar.gz"
    sha256 "84ab92ed1c4d4f16916e05906b6b75a6c0fb5db821cc65e70cbd64a3e2a5eaae"
  end

  resource "ckcc-protocol" do
    url "https://files.pythonhosted.org/packages/7f/a4/f39c0cfcc8eb8fe72084ec22022d32f7c3d07b7611a353cc7f1a3a8c4b32/ckcc-protocol-0.7.2.tar.gz"
    sha256 "498db4ccdda018cd9f40210f5bd02ddcc98e7df583170b2eab4035c86c3cc03b"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/f8/5c/f60e9d8a1e77005f664b76ff8aeaee5bc05d0a91798afd7f53fc998dbc47/Click-7.0.tar.gz"
    sha256 "5b94b49521f6456670fdb30cd82a4eca9412788a93fa6dd6df72c94d5a8ff2d7"
  end

  resource "construct" do
    url "https://files.pythonhosted.org/packages/19/c0/f054941fa33d14378de66d2c0477d31f7ad97aa2e298a5771a7b20bc2039/construct-2.9.45.tar.gz"
    sha256 "2271a0efd0798679dea825ff47e22a4c550456a5db0ba8baa82f7eae0af0118c"
  end

  resource "dnspython" do
    url "https://files.pythonhosted.org/packages/ec/c5/14bcd63cb6d06092a004793399ec395405edf97c2301dfdc146dfbd5beed/dnspython-1.16.0.zip"
    sha256 "36c5e8e38d4369a08b6780b7f27d790a292b2b08eea01607865bf0936c558e01"
  end

  resource "ecdsa" do
    url "https://files.pythonhosted.org/packages/f9/e5/99ebb176e47f150ac115ffeda5fedb6a3dbb3c00c74a59fd84ddf12f5857/ecdsa-0.13.tar.gz"
    sha256 "64cf1ee26d1cde3c73c6d7d107f835fed7c6a2904aef9eac223d57ad800c43fa"
  end

  resource "hidapi" do
    url "https://files.pythonhosted.org/packages/c1/86/89df0e8890f96eeb5fb68d4ccb14cb38e2c2d2cfd7601ba972206acd9015/hidapi-0.7.99.post21.tar.gz"
    sha256 "e0be1aa6566979266a8fc845ab0e18613f4918cf2c977fe67050f5dc7e2a9a97"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/ad/13/eb56951b6f7950cadb579ca166e448ba77f9d24efc03edd7e55fa57d04b7/idna-2.8.tar.gz"
    sha256 "c357b3f628cf53ae2c4c05627ecc484553142ca23264e593d327bcde5e9c3407"
  end

  resource "jsonrpclib-pelix" do
    url "https://files.pythonhosted.org/packages/5c/4e/67c832052d6d85731732193b5d58ff9c2c3ec91087324ad5c2d814fc56c9/jsonrpclib-pelix-0.4.0.tar.gz"
    sha256 "19c558e169a51480b39548783067ca55046b62b2409ab4559931255e12f635de"
  end

  resource "keepkey" do
    url "https://files.pythonhosted.org/packages/d2/0f/433b95333278466204a3e4ba79836198957d697f36227ea2c462e4a51917/keepkey-6.0.2.tar.gz"
    sha256 "af107f610fb0e2417fc7a9d87a2fa22aac9b80b79559370d178be424bb85489a"
  end

  resource "libusb1" do
    url "https://files.pythonhosted.org/packages/9c/51/25f5218d9e21bac3e36bb7167d7d9dfe899cd48bebfe60a54cd39c5db585/libusb1-1.7.tar.gz"
    sha256 "9d4f66d2ed699986b06bc3082cd262101cb26af7a76a34bd15b7eb56cba37e0f"
  end

  resource "mnemonic" do
    url "https://files.pythonhosted.org/packages/a4/5a/663362ccceb76035ad50fbc20203b6a4674be1fe434886b7407e79519c5e/mnemonic-0.18.tar.gz"
    sha256 "02a7306a792370f4a0c106c2cf1ce5a0c84b9dbd7e71c6792fdb9ad88a727f1d"
  end

  resource "multidict" do
    url "https://files.pythonhosted.org/packages/7f/8f/b3c8c5b062309e854ce5b726fc101195fbaa881d306ffa5c2ba19efa3af2/multidict-4.5.2.tar.gz"
    sha256 "024b8129695a952ebd93373e45b5d341dbb87c17ce49637b34000093f243dd4f"
  end

  resource "pbkdf2" do
    url "https://files.pythonhosted.org/packages/02/c0/6a2376ae81beb82eda645a091684c0b0becb86b972def7849ea9066e3d5e/pbkdf2-1.3.tar.gz"
    sha256 "ac6397369f128212c43064a2b4878038dab78dab41875364554aaf2a684e6979"
  end

  resource "protobuf" do
    url "https://files.pythonhosted.org/packages/93/4a/ba399b29924ba56e7bf84fd5245251ebd160fc9777b4f2e145d10d61f5d2/protobuf-3.7.0.tar.gz"
    sha256 "ad385fbb9754023d17be14dd5aa67efff07f43c5df7f93118aef3c20e635ea19"
  end

  resource "pyaes" do
    url "https://files.pythonhosted.org/packages/44/66/2c17bae31c906613795711fc78045c285048168919ace2220daa372c7d72/pyaes-1.6.1.tar.gz"
    sha256 "02c1b1405c38d3c370b085fb952dd8bea3fadcee6411ad99f312cc129c536d8f"
  end

  resource "pyblake2" do
    url "https://files.pythonhosted.org/packages/a6/ea/559658f48713567276cabe1344a9ef918adcb34a9da417dbf0a2f7477d8e/pyblake2-1.1.2.tar.gz"
    sha256 "5ccc7eb02edb82fafb8adbb90746af71460fbc29aa0f822526fc976dff83e93f"
  end

  resource "qrcode" do
    url "https://files.pythonhosted.org/packages/19/d5/6c7d4e103d94364d067636417a77a6024219c58cd6e9f428ece9b5061ef9/qrcode-6.1.tar.gz"
    sha256 "505253854f607f2abf4d16092c61d4e9d511a3b4392e60bff957a68592b04369"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/52/2c/514e4ac25da2b08ca5a464c50463682126385c4272c18193876e91f4bc38/requests-2.21.0.tar.gz"
    sha256 "502a824f31acdacb3a35b6690b5fbf0bc41d63a24a45c4004352b0242707598e"
  end

  resource "safet" do
    url "https://files.pythonhosted.org/packages/94/dd/31e2d333e61d80baa0d24dcb12f890d17e803f7d6f73145a4fa4c41058b4/safet-0.1.4.tar.gz"
    sha256 "b152874acdc89ff0c8b2d680bfbf020b3e53527c2ad3404489dd61a548aa56a1"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/dd/bf/4138e7bfb757de47d1f4b6994648ec67a51efe58fa907c1e11e350cddfca/six-1.12.0.tar.gz"
    sha256 "d16a0141ec1a18405cd4ce8b4613101da75da0e9a7aec5bdd4fa804d0e0eba73"
  end

  resource "trezor" do
    url "https://files.pythonhosted.org/packages/42/6a/283786bfb63aacfaa4b82891c906d27880feed32a62692db1fdb36a15b51/trezor-0.11.2.tar.gz"
    sha256 "a6f4b47b37a21247535fc43411cb70a8c61ef0a5a2dfee668bd05611e2741fb8"
  end

  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/fa/aa/229f5c82d17d10d4ef318b5c22a8626a1c78fc97f80d3307035cf696681b/typing_extensions-3.7.2.tar.gz"
    sha256 "fb2cd053238d33a8ec939190f30cfd736c00653a85a2919415cecf7dc3d9da71"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/b1/53/37d82ab391393565f2f831b8eedbffd57db5a718216f82f1a8b4d381a1c1/urllib3-1.24.1.tar.gz"
    sha256 "de9529817c93f27c8ccbfead6985011db27bd0ddfcdb2d86f3f663385c6a9c22"
  end

  resource "websocket_client" do
    url "https://files.pythonhosted.org/packages/23/f9/d31c5ce35bdd865de3aa6453c0cae13a7fe6799a8b0d6967c767bbb83a30/websocket_client-0.55.0.tar.gz"
    sha256 "f6029deea21218f2c771848935aa26c15699c831770f4fa66958bdaabff80ca0"
  end

  resource "yarl" do
    url "https://files.pythonhosted.org/packages/fb/84/6d82f6be218c50b547aa29d0315e430cf8a23c52064c92d0a8377d7b7357/yarl-1.3.0.tar.gz"
    sha256 "024ecdc12bc02b321bc66b41327f930d1c2c543fa9a561b39861da9388ba7aa9"
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
