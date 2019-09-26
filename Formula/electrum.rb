class Electrum < Formula
  include Language::Python::Virtualenv

  desc "Bitcoin thin client"
  homepage "https://electrum.org"
  url "https://download.electrum.org/3.3.8/Electrum-3.3.8.tar.gz"
  sha256 "e2adf191847609d5bd850320f647db6347952b170364a463276db27a836400bc"
  revision 1

  bottle do
    root_url "https://dl.bintray.com/domt4/crypto-bottles"
    cellar :any_skip_relocation
    sha256 "22fb78c85de595f0ea632c01c26853768de55d3d5e5b90d54f5bb1344d4d51b3" => :mojave
  end

  depends_on "protobuf"
  depends_on "pyqt"
  depends_on "python"

  resource "Cython" do
    url "https://files.pythonhosted.org/packages/5b/5b/6cba7123a089c4174f944dd05ea7984c8d908aba8746a99f2340dde8662f/Cython-0.29.12.tar.gz"
    sha256 "20da832a5e9a8e93d1e1eb64650258956723940968eb585506531719b55b804f"
  end

  resource "QDarkStyle" do
    url "https://files.pythonhosted.org/packages/a4/ec/c6ae1509370f07ef2ac725cfed6add23b94670a5903a834a463440ca295a/QDarkStyle-2.6.8.tar.gz"
    sha256 "037a54bf0aa5153f8055b65b8b36ac0d0f7648f2fd906c011a4da22eb0f582a2"
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
    url "https://files.pythonhosted.org/packages/4e/c5/9aacc2f50e06919c3f1d34137d1acea980f2449df7c4f9149c37b306e492/aiorpcX-0.18.3.tar.gz"
    sha256 "b7a7ced5df95c79c74f7834e7cc58bb7747dbad9eb37bf7580da507e182ca44c"
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
    url "https://files.pythonhosted.org/packages/c5/67/5d0548226bcc34468e23a0333978f0e23d28d0b3f0c71a151aef9c3f7680/certifi-2019.6.16.tar.gz"
    sha256 "945e3ba63a0b9f577b1395204e13c3a231f9bc0223888be653286534e5873695"
  end

  resource "chardet" do
    url "https://files.pythonhosted.org/packages/fc/bb/a5768c230f9ddb03acc9ef3f0d4a3cf93462473795d18e9535498c8f929d/chardet-3.0.4.tar.gz"
    sha256 "84ab92ed1c4d4f16916e05906b6b75a6c0fb5db821cc65e70cbd64a3e2a5eaae"
  end

  resource "ckcc-protocol" do
    url "https://files.pythonhosted.org/packages/35/9a/a49ee1591dc7d532a6905988934cbd94e44e917f2d5660b2d3d88239ec3f/ckcc-protocol-0.7.7.tar.gz"
    sha256 "3c3815342354ccbf63ba7ecfa5f0c27e56a308d7157f1b02835868977659c979"
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
    url "https://files.pythonhosted.org/packages/51/76/139bf6e9b7b6684d5891212cdbd9e0739f2bfc03f380a1a6ffa700f392ac/ecdsa-0.13.2.tar.gz"
    sha256 "5c034ffa23413ac923541ceb3ac14ec15a0d2530690413bff58c12b80e56d884"
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
    url "https://files.pythonhosted.org/packages/61/f7/5487352c4a724fa864c442938b4b44244beaeec34e1d351916611441345f/keepkey-6.1.0.tar.gz"
    sha256 "2e1623409307c86f709054ad191bc7707c4feeacae2e497bd933f2f0054c6eb0"
  end

  resource "libusb1" do
    url "https://files.pythonhosted.org/packages/80/bb/4ee9d760dd29499d877ee384f1d2bc6bb9923defd4c69843aef5e729972d/libusb1-1.7.1.tar.gz"
    sha256 "adf64a4f3f5c94643a1286f8153bcf4bc787c348b38934aacd7fe17fbeebc571"
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
    url "https://files.pythonhosted.org/packages/cd/02/0425c38def9047d77166abdc9bb66dcff2882095c57b952511c85720f03c/protobuf-3.9.0.tar.gz"
    sha256 "b3452bbda12b1cbe2187d416779de07b2ab4c497d83a050e43c344778763721d"
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
    url "https://files.pythonhosted.org/packages/01/62/ddcf76d1d19885e8579acb1b1df26a852b03472c0e46d2b959a714c90608/requests-2.22.0.tar.gz"
    sha256 "11e007a8a2aa0323f5a921e9e6a2d7e4e67d9877e85773fba9ba6419025cbeb4"
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
    url "https://files.pythonhosted.org/packages/88/9e/9b84a35c3709cda7b35a211dc9617f38740eb2d3a46a20a1087efb795302/trezor-0.11.3.tar.gz"
    sha256 "c79a500e90d003073c8060d319dceb042caaba9472f13990c77ed37d04a82108"
  end

  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/59/b6/21774b993eec6e797fbc49e53830df823b69a3cb62f94d36dfb497a0b65a/typing_extensions-3.7.4.tar.gz"
    sha256 "2ed632b30bb54fc3941c382decfd0ee4148f5c591651c9272473fea2c6397d95"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/4c/13/2386233f7ee40aa8444b47f7463338f3cbdf00c316627558784e3f542f07/urllib3-1.25.3.tar.gz"
    sha256 "dbe59173209418ae49d485b87d1681aefa36252ee85884c31346debd19463232"
  end

  resource "websocket_client" do
    url "https://files.pythonhosted.org/packages/c5/01/8c9c7de6c46f88e70b5a3276c791a2be82ae83d8e0d0cc030525ee2866fd/websocket_client-0.56.0.tar.gz"
    sha256 "1fd5520878b68b84b5748bb30e592b10d0a91529d5383f74f4964e72b297fd3a"
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
