class Electrum < Formula
  include Language::Python::Virtualenv

  desc "Bitcoin thin client"
  homepage "https://electrum.org"
  url "https://download.electrum.org/3.0.2/Electrum-3.0.2.tar.gz"
  sha256 "4dff75bc5f496f03ad7acbe33f7cec301955ef592b0276f2c518e94e47284f53"

  depends_on "protobuf"
  depends_on "pyqt"
  depends_on :python3

  resource "PySocks" do
    url "https://files.pythonhosted.org/packages/7d/38/edca891ce16827a1de45cc347e4b6c22311eba25838b9825a5e6c48cf560/PySocks-1.6.7.tar.gz"
    sha256 "d00329f27efa157db7efe3ca26fcd69033cd61f83822461ee3f8a353b48e33cf"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/23/3f/8be01c50ed24a4bd6b8da799839066ce0288f66f5e11f0367323467f0cbc/certifi-2017.11.5.tar.gz"
    sha256 "5ec74291ca1136b40f0379e1128ff80e866597e4e2c1e755739a913bbc3613c0"
  end

  resource "chardet" do
    url "https://files.pythonhosted.org/packages/fc/bb/a5768c230f9ddb03acc9ef3f0d4a3cf93462473795d18e9535498c8f929d/chardet-3.0.4.tar.gz"
    sha256 "84ab92ed1c4d4f16916e05906b6b75a6c0fb5db821cc65e70cbd64a3e2a5eaae"
  end

  resource "dnspython" do
    url "https://files.pythonhosted.org/packages/e4/96/a598fa35f8a625bc39fed50cdbe3fd8a52ef215ef8475c17cabade6656cb/dnspython-1.15.0.zip"
    sha256 "40f563e1f7a7b80dc5a4e76ad75c23da53d62f1e15e6e517293b04e1f84ead7c"
  end

  resource "ecdsa" do
    url "https://files.pythonhosted.org/packages/f9/e5/99ebb176e47f150ac115ffeda5fedb6a3dbb3c00c74a59fd84ddf12f5857/ecdsa-0.13.tar.gz"
    sha256 "64cf1ee26d1cde3c73c6d7d107f835fed7c6a2904aef9eac223d57ad800c43fa"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/f4/bd/0467d62790828c23c47fc1dfa1b1f052b24efdf5290f071c7a91d0d82fd3/idna-2.6.tar.gz"
    sha256 "2c6a5de3089009e3da7c5dde64a141dbc8551d5b7f6cf4ed7c2568d0cc520a8f"
  end

  resource "jsonrpclib-pelix" do
    url "https://files.pythonhosted.org/packages/cc/a9/8767fbdaad0e5f53803d5d0e5f5cc778dc1efbabe7f2891e4b95806246b8/jsonrpclib-pelix-0.3.1.tar.gz"
    sha256 "5417b1508d5a50ec64f6e5b88907f111155d52607b218ff3ba9a777afb2e49e3"
  end

  resource "pbkdf2" do
    url "https://files.pythonhosted.org/packages/02/c0/6a2376ae81beb82eda645a091684c0b0becb86b972def7849ea9066e3d5e/pbkdf2-1.3.tar.gz"
    sha256 "ac6397369f128212c43064a2b4878038dab78dab41875364554aaf2a684e6979"
  end

  resource "protobuf" do
    url "https://files.pythonhosted.org/packages/24/5f/545a0a1a169417283e63f5a0bf7af8a68ac4a451b56ef5ba2fd3985004e5/protobuf-3.5.0.tar.gz"
    sha256 "5dc58d69207af74e07c56c7b5c5c5dcb60f44b9c9b7c0a17a06ae50808072edc"
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

  resource "six" do
    url "https://files.pythonhosted.org/packages/16/d8/bc6316cf98419719bd59c91742194c111b6f2e85abac88e496adefaf7afe/six-1.11.0.tar.gz"
    sha256 "70e8a77beed4562e7f14fe23a786b54f6296e34344c23bc42f07b15018ff98e9"
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
