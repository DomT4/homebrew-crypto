class Electrum < Formula
  include Language::Python::Virtualenv

  desc "Bitcoin thin client"
  homepage "https://electrum.org"
  url "https://download.electrum.org/4.1.5/Electrum-4.1.5.tar.gz"
  sha256 "91472e281f604a7a687faa4b339bf5e484bd2bec82a495ea45bfa014e52719a1"

  bottle do
    root_url "https://dl.cloudsmith.io/public/homebrew-crypto/homebrew-crypto/raw/files/"
    sha256 arm64_big_sur: "24818be52857f5393569b3a696651641c983183570cb2f93022a6dcb63ad9c3f"
  end

  depends_on "cython" => :build
  # A little stunningly, cryptography now requires a whole Rust compiler to
  # build. We could use `CRYPTOGRAPHY_DONT_BUILD_RUST=1` but that seems to be
  # a hack rather than something upstream want to support indefinitely.
  depends_on "rust" => :build
  depends_on "secp256k1" => :build
  depends_on "protobuf"
  depends_on "pyqt@5" # Check contrib/requirements/requirements-binaries-mac.txt
  depends_on "python"

  # It's really annoying this is required because it makes the build *a lot*
  # slower than it would otherwise be. Need to look into this more to see if
  # it's possible to just go back to using the core pyqt Python bindings
  # without constantly hitting `ModuleNotFoundError: No module named 'PyQt5.sip'`.
  resource "PyQt5-sip" do
    url "https://files.pythonhosted.org/packages/b1/40/dd8f081f04a12912b65417979bf2097def0af0f20c89083ada3670562ac5/PyQt5_sip-12.9.0.tar.gz"
    sha256 "d3e4489d7c2b0ece9d203ae66e573939f7f60d4d29e089c9f11daa17cfeaae32"
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
    url "https://files.pythonhosted.org/packages/ed/d6/3ebca4ca65157c12bd08a63e20ac0bdc21ac7f3694040711f9fd073c0ffb/attrs-21.2.0.tar.gz"
    sha256 "ef6aaac3ca6cd92904cdd0d83f629a15f18053ec84e6432106f7a4d04ae4f5fb"
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
    url "https://files.pythonhosted.org/packages/4c/b1/80d58eeb21c9d4ca739770558d61f6adacb13aa4908f4f55e0974cbd25ee/bitstring-3.1.9.tar.gz"
    sha256 "a5848a3f63111785224dca8bb4c0a75b62ecdef56a042c8d6be74b16f7e860e7"
  end

  resource "btchip-python" do
    url "https://files.pythonhosted.org/packages/30/fd/16394adaff5736840aeda77163d5f6f593091d687a1807ff02dedcfc7bca/btchip-python-0.1.32.tar.gz"
    sha256 "34f5e0c161c08f65dc0d070ba2ff4c315ed21c4b7e0faa32a46862d0dc1b8f55"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/6d/78/f8db8d57f520a54f0b8a438319c342c61c22759d8f9a1cd2e2180b5e5ea9/certifi-2021.5.30.tar.gz"
    sha256 "2bbf76fd432960138b3ef6dda3dde0544f27cbf8546c458e60baf371917ba9ee"
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
    url "https://files.pythonhosted.org/packages/21/83/308a74ca1104fe1e3197d31693a7a2db67c2d4e668f20f43a2fca491f9f7/click-8.0.1.tar.gz"
    sha256 "8c04c11192119b1ef78ea049e0a6f0463e4c48ef00a30160c704337586f3ad7a"
  end

  resource "construct" do
    url "https://files.pythonhosted.org/packages/39/2b/c68eaf8294f01ea534f39b8b4ec1d7308b5195e08570c276b104bccd24ff/construct-2.10.67.tar.gz"
    sha256 "730235fedf4f2fee5cfadda1d14b83ef1bf23790fb1cc579073e10f70a050883"
  end

  resource "cryptography" do
    url "https://files.pythonhosted.org/packages/9b/77/461087a514d2e8ece1c975d8216bc03f7048e6090c5166bc34115afdaa53/cryptography-3.4.7.tar.gz"
    sha256 "3d10de8116d25649631977cb37da6cbdd2d6fa0e0281d014a5b7d337255ca713"
  end

  resource "dnspython" do
    url "https://files.pythonhosted.org/packages/67/d0/639a9b5273103a18c5c68a7a9fc02b01cffa3403e72d553acec444f85d5b/dnspython-2.0.0.zip"
    sha256 "044af09374469c3a39eeea1a146e8cac27daec951f1f1f157b1962fc7cb9d1b7"
  end

  resource "ecdsa" do
    url "https://files.pythonhosted.org/packages/bf/3d/3d909532ad541651390bf1321e097404cbd39d1d89c2046f42a460220fb3/ecdsa-0.17.0.tar.gz"
    sha256 "b9f500bb439e4153d0330610f5d26baaf18d17b8ced1bc54410d189385ea68aa"
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
    url "https://files.pythonhosted.org/packages/cb/38/4c4d00ddfa48abe616d7e572e02a04273603db446975ab46bbcd36552005/idna-3.2.tar.gz"
    sha256 "467fbad99067910785144ce333826c71fb0e63a425657295239737f7ecd125f3"
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
    url "https://files.pythonhosted.org/packages/3d/64/a3b379cb9c7827ad33c67dcda4c4ad117bdef1b7d68b22a05c963cf4727d/protobuf-3.17.3.tar.gz"
    sha256 "72804ea5eaa9c22a090d2803813e280fb273b62d5ae497aaf3553d141c4fdd7b"
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
    url "https://files.pythonhosted.org/packages/c2/86/7d61342b7dacf012426326e3c063f4ea5a89860d7325775863b8979cd5aa/python-socks-1.2.4.tar.gz"
    sha256 "7d0ef2578cead9f762b71317d25a6c118fabaf79535555e75b3e102f5158ddd8"
  end

  resource "qrcode" do
    url "https://files.pythonhosted.org/packages/99/6f/3914ab406164775a6293ebe001e57d23e38c09d51f3909c45bd132684927/qrcode-7.2.tar.gz"
    sha256 "153ad96f5892e6fe2f3699296240976ac3a6d068e2eb48bbfc64b4c4c4d675ea"
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
    url "https://files.pythonhosted.org/packages/71/39/171f1c67cd00715f190ba0b100d606d440a28c93c7714febeca8b79af85e/six-1.16.0.tar.gz"
    sha256 "1e61c37477a1626458e36f7b1d82aa5c9b094fa4802892072e49de9c60c4c926"
  end

  resource "trezor" do
    url "https://files.pythonhosted.org/packages/40/bb/e5aff94fb22fcce0b57dd773b5fd1e8b7bdd16c4bc982755984b9a09bb7d/trezor-0.12.2.tar.gz"
    sha256 "5bd226b829e5f6ad6c7263f5303f58b54e07b0f21263c4b8ba57981881071264"
  end

  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/aa/55/62e2d4934c282a60b4243a950c9dbfa01ae7cac0e8d6c0b5315b87432c81/typing_extensions-3.10.0.0.tar.gz"
    sha256 "50b6f157849174217d0656f99dc82fe932884fb250826c18350e159ec6cdf342"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/94/40/c396b5b212533716949a4d295f91a4c100d51ba95ea9e2d96b6b0517e5a5/urllib3-1.26.5.tar.gz"
    sha256 "a7acd0977125325f516bda9735fa7142b909a8d01e8b2e4c8108d0984e6e0098"
  end

  resource "yarl" do
    url "https://files.pythonhosted.org/packages/97/e7/af7219a0fe240e8ef6bb555341a63c43045c21ab0392b4435e754b716fa1/yarl-1.6.3.tar.gz"
    sha256 "8a9066529240171b68893d60dca86a763eae2139dd42f42106b03cf4b426bf10"
  end

  def install
    # https://stackoverflow.com/a/44466013
    ENV.delete("PYTHONPATH")

    virtualenv_install_with_resources

    cp Dir[Formula["secp256k1"].opt_lib/"*"].select { |f| File.file? f },
       libexec/"lib/python3.9/site-packages/electrum/"
  end

  test do
    system bin/"electrum", "--help"
  end
end
