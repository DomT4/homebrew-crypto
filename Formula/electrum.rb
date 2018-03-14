class Electrum < Formula
  include Language::Python::Virtualenv

  desc "Bitcoin thin client"
  homepage "https://electrum.org"
  url "https://download.electrum.org/3.1.1/Electrum-3.1.1.tar.gz"
  sha256 "3195679f898bd763c6db32f46bbdf59fa5a211fd3013507f5c7aab25d9b94337"

  depends_on "protobuf"
  depends_on "pyqt"
  depends_on "python3"

  resource "Cython" do
    url "https://files.pythonhosted.org/packages/fa/86/0c8311bcba3b3f0944c135db95312e057a353058f522692e4dcf6d4bb978/Cython-0.28.tar.gz"
    sha256 "518f7e22da54109661e483a91a63045203caf9fd78da4a69185a7622f759965f"
  end

  resource "PySocks" do
    url "https://files.pythonhosted.org/packages/53/12/6bf1d764f128636cef7408e8156b7235b150ea31650d0260969215bb8e7d/PySocks-1.6.8.tar.gz"
    sha256 "3fe52c55890a248676fd69dc9e3c4e811718b777834bcaab7a8125cf9deac672"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/15/d4/2f888fc463d516ff7bf2379a4e9a552fef7f22a94147655d9b1097108248/certifi-2018.1.18.tar.gz"
    sha256 "edbc3f203427eef571f79a7692bb160a2b0f7ccaa31953e99bd17e307cf63f7d"
  end

  resource "chardet" do
    url "https://files.pythonhosted.org/packages/fc/bb/a5768c230f9ddb03acc9ef3f0d4a3cf93462473795d18e9535498c8f929d/chardet-3.0.4.tar.gz"
    sha256 "84ab92ed1c4d4f16916e05906b6b75a6c0fb5db821cc65e70cbd64a3e2a5eaae"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/95/d9/c3336b6b5711c3ab9d1d3a80f1a3e2afeb9d8c02a7166462f6cc96570897/click-6.7.tar.gz"
    sha256 "f15516df478d5a56180fbf80e68f206010e6d160fc39fa508b65e035fd75130b"
  end

  resource "dnspython" do
    url "https://files.pythonhosted.org/packages/e4/96/a598fa35f8a625bc39fed50cdbe3fd8a52ef215ef8475c17cabade6656cb/dnspython-1.15.0.zip"
    sha256 "40f563e1f7a7b80dc5a4e76ad75c23da53d62f1e15e6e517293b04e1f84ead7c"
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
    url "https://files.pythonhosted.org/packages/f4/bd/0467d62790828c23c47fc1dfa1b1f052b24efdf5290f071c7a91d0d82fd3/idna-2.6.tar.gz"
    sha256 "2c6a5de3089009e3da7c5dde64a141dbc8551d5b7f6cf4ed7c2568d0cc520a8f"
  end

  resource "jsonrpclib-pelix" do
    url "https://files.pythonhosted.org/packages/cc/a9/8767fbdaad0e5f53803d5d0e5f5cc778dc1efbabe7f2891e4b95806246b8/jsonrpclib-pelix-0.3.1.tar.gz"
    sha256 "5417b1508d5a50ec64f6e5b88907f111155d52607b218ff3ba9a777afb2e49e3"
  end

  resource "keepkey" do
    url "https://files.pythonhosted.org/packages/bd/7c/8edc3d017b4b02f11533083d9987d11707fcf82ab6606c9b9aedd2e95b4c/keepkey-4.0.2.tar.gz"
    sha256 "cddee60ae405841cdff789cbc54168ceaeb2282633420f2be155554c25c69138"
  end

  resource "libusb1" do
    url "https://files.pythonhosted.org/packages/ec/5d/4fdac6c53525786fe35cff035c3345452e24e2bee5627893be65d12555cb/libusb1-1.6.4.tar.gz"
    sha256 "8c930d9c1d037d9c83924c82608aa6a1adcaa01ca0e4a23ee0e8e18d7eee670d"
  end

  resource "mnemonic" do
    url "https://files.pythonhosted.org/packages/a4/5a/663362ccceb76035ad50fbc20203b6a4674be1fe434886b7407e79519c5e/mnemonic-0.18.tar.gz"
    sha256 "02a7306a792370f4a0c106c2cf1ce5a0c84b9dbd7e71c6792fdb9ad88a727f1d"
  end

  resource "pbkdf2" do
    url "https://files.pythonhosted.org/packages/02/c0/6a2376ae81beb82eda645a091684c0b0becb86b972def7849ea9066e3d5e/pbkdf2-1.3.tar.gz"
    sha256 "ac6397369f128212c43064a2b4878038dab78dab41875364554aaf2a684e6979"
  end

  resource "pyblake2" do
    url "https://files.pythonhosted.org/packages/cc/a6/3fa4c5cd5c3f590187cc31e5d5089332fb46c3a9912a28d5c44d34268cd4/pyblake2-1.1.0.tar.gz"
    sha256 "3a850036bf42053c74bfc52c063323ca78e40ba1f326b01777da5750a143631a"
  end

  resource "protobuf" do
    url "https://files.pythonhosted.org/packages/f2/2f/7c8475f523b6db67506eba48d3beacc3625e0effabfac109848f19e3cffc/protobuf-3.5.2.tar.gz"
    sha256 "09879a295fd7234e523b62066223b128c5a8a88f682e3aff62fb115e4a0d8be0"
  end

  resource "pyaes" do
    url "https://files.pythonhosted.org/packages/44/66/2c17bae31c906613795711fc78045c285048168919ace2220daa372c7d72/pyaes-1.6.1.tar.gz"
    sha256 "02c1b1405c38d3c370b085fb952dd8bea3fadcee6411ad99f312cc129c536d8f"
  end

  resource "qrcode" do
    url "https://files.pythonhosted.org/packages/87/16/99038537dc58c87b136779c0e06d46887ff5104eb8c64989aac1ec8cba81/qrcode-5.3.tar.gz"
    sha256 "4115ccee832620df16b659d4653568331015c718a754855caf5930805d76924e"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/b0/e1/eab4fc3752e3d240468a8c0b284607899d2fbfb236a56b7377a329aa8d09/requests-2.18.4.tar.gz"
    sha256 "9c443e7324ba5b85070c4a818ade28bfabedf16ea10206da1132edaa6dda237e"
  end

  resource "rlp" do
    url "https://files.pythonhosted.org/packages/f9/53/922c7a15116e52cd7340f81b83322d5ec9d38668cd78d1a0c7e75dfce8f2/rlp-0.6.0.tar.gz"
    sha256 "87879a0ba1479b760cee98af165de2eee95258b261faa293199f60742be96f34"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/16/d8/bc6316cf98419719bd59c91742194c111b6f2e85abac88e496adefaf7afe/six-1.11.0.tar.gz"
    sha256 "70e8a77beed4562e7f14fe23a786b54f6296e34344c23bc42f07b15018ff98e9"
  end

  resource "trezor" do
    url "https://files.pythonhosted.org/packages/26/46/b78ba738beea1d451a9f88b55edde8d1fac1049b69157aeaf12390ec00b6/trezor-0.9.1.tar.gz"
    sha256 "a481191011bade98f1e9f1201e7c72a83945050657bbc90dc4ac32dc8b8b46a4"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/ee/11/7c59620aceedcc1ef65e156cc5ce5a24ef87be4107c2b74458464e437a5d/urllib3-1.22.tar.gz"
    sha256 "cc44da8e1145637334317feebd728bd869a35285b93cbb4cca2577da7e62db4f"
  end

  def install
    # https://stackoverflow.com/a/44466013
    ENV.delete("PYTHONPATH")

    virtualenv_install_with_resources

    xy = Language::Python.major_minor_version "python3"
    sp = libexec/"lib/python#{xy}/site-packages"
    system "pyrcc5", "icons.qrc", "-o", sp/"electrum_gui/qt/icons_rc.py"
  end

  test do
    system bin/"electrum", "--help"
  end
end
