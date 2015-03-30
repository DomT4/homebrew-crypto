class Electrum < Formula
  homepage "https://electrum.org/"
  url "https://download.electrum.org/Electrum-2.0.4.tar.gz"
  sha256 "b77f70efbe337387dd9654c660b96dc5608ff7a76fe8fdc573d747e17fce3b61"
  head "https://github.com/spesmilo/electrum.git"

  depends_on :python if MacOS.version <= :snow_leopard
  depends_on "pkg-config" => :build
  depends_on "pyqt"
  depends_on "sip"
  depends_on "qt"
  depends_on "gettext"
  depends_on "protobuf" => "with-python"

  resource "six" do
    url "https://pypi.python.org/packages/source/s/six/six-1.9.0.tar.gz"
    sha256 "e24052411fc4fbd1f672635537c3fc2330d9481b18c0317695b46259512c91d5"
  end

  resource "slowaes" do
    url "https://pypi.python.org/packages/source/s/slowaes/slowaes-0.1a1.tar.gz"
    sha256 "83658ae54cc116b96f7fdb12fdd0efac3a4e8c7c7064e3fac3f4a881aa54bf09"
  end

  resource "pbkdf2" do
    url "https://pypi.python.org/packages/source/p/pbkdf2/pbkdf2-1.3.tar.gz"
    sha256 "ac6397369f128212c43064a2b4878038dab78dab41875364554aaf2a684e6979"
  end

  resource "requests" do
    url "https://pypi.python.org/packages/source/r/requests/requests-2.6.0.tar.gz"
    sha256 "1cdbed1f0e236f35ef54e919982c7a338e4fea3786310933d3a7887a04b74d75"
  end

  resource "pyasn1" do
    url "https://pypi.python.org/packages/source/p/pyasn1/pyasn1-0.1.7.tar.gz"
    sha256 "e4f81d53c533f6bd9526b047f047f7b101c24ab17339c1a7ad8f98b25c101eab"
  end

  resource "pyasn1modules" do
    url "https://pypi.python.org/packages/source/p/pyasn1-modules/pyasn1-modules-0.0.5.tar.gz"
    sha256 "be65f00ed28e30756f1ef39377cb382480a2368699179d646a84d79fe9349941"
  end

  resource "qrcode" do
    url "https://pypi.python.org/packages/source/q/qrcode/qrcode-5.1.tar.gz"
    sha256 "33bdee5e834fc99eb538e1dad198a3a5b70d0a88845629cacf4c592be1ce7f6a"
  end

  resource "socksipy" do
    url "https://pypi.python.org/packages/source/S/SocksiPy-branch/SocksiPy-branch-1.01.tar.gz"
    sha256 "17a95060e28c3b9038a9b8c1865c54f8c1c5bef15d561bf777c9bbf3c80e8406"
  end

  resource "tlslite" do
    url "https://pypi.python.org/packages/source/t/tlslite/tlslite-0.4.8.tar.gz"
    sha256 "d9b447048a322c70df800f540ab577c93ecf20de52c0a02c8621176e4733bdbb"
  end

  resource "pycurl" do
    url "https://pypi.python.org/packages/source/p/pycurl/pycurl-7.19.5.1.tar.gz"
    sha256 "6e9770f80459757f73bd71af82fbb29cd398b38388cdf1beab31ea91a331bc6c"
  end

  resource "dnspython" do
    url "https://pypi.python.org/packages/source/d/dnspython/dnspython-1.12.0.zip"
    sha256 "63bd1fae61809eedb91f84b2185816fac1270ae51494fbdd36ea25f904a8502f"
  end

  def install
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python2.7/site-packages"
    %w[six slowaes pbkdf2 requests pyasn1 pyasn1modules qrcode socksipy tlslite pycurl dnspython].each do |r|
      resource(r).stage do
        system "python", *Language::Python.setup_install_args(libexec/"vendor")
      end
    end

    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python2.7/site-packages"
    system "pyrcc4", "icons.qrc", "-o", "gui/qt/icons_rc.py"
    system "python", *Language::Python.setup_install_args(libexec)

    bin.install Dir["#{libexec}/bin/*"]
    bin.env_script_all_files(libexec+"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end

  def caveats; <<-EOS.undent
    To finish installation you must do:
      pip install ecdsa
    EOS
  end
end
