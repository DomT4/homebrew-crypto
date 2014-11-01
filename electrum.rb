require "formula"

class Electrum < Formula
  homepage "https://electrum.org/"
  url "https://download.electrum.org/Electrum-1.9.8.tar.gz"
  sha256 "8fc144a32013e4a747fea27fff981762a6b9e14cde9ffb405c4c721975d846ff"
  head "https://github.com/spesmilo/electrum.git"

  depends_on :python if MacOS.version <= :snow_leopard
  depends_on "pkg-config" => :build
  depends_on "pyqt"
  depends_on "sip"
  depends_on "qt"
  depends_on "gettext"

  resource "slowaes" do
    url "https://pypi.python.org/packages/source/s/slowaes/slowaes-0.1a1.tar.gz"
    sha256 "83658ae54cc116b96f7fdb12fdd0efac3a4e8c7c7064e3fac3f4a881aa54bf09"
  end

  resource "pbkdf2" do
    url "https://pypi.python.org/packages/source/p/pbkdf2/pbkdf2-1.3.tar.gz"
    sha256 "ac6397369f128212c43064a2b4878038dab78dab41875364554aaf2a684e6979"
  end

  resource "requests" do
    url "https://pypi.python.org/packages/source/r/requests/requests-2.4.3.tar.gz"
    sha256 "53c68313c5c6149b1a899234c000296e60a8900682accf73d6f0c6d608afc6b1"
  end

  resource "pyasn" do
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
    url "https://pypi.python.org/packages/source/t/tlslite/tlslite-0.4.6.tar.gz"
    sha256 "5a707af9afbd27cf99c87697ce2f7e87752cf160f20384212bc2d1d42ea7dd08"
  end

  resource "pycurl" do
    url "https://pypi.python.org/packages/source/p/pycurl/pycurl-7.19.5.tar.gz"
    sha256 "69a0aa7c9dddbfe4cebf4d1f674c490faccf739fc930d85d8990ce2fd0551a43"
  end

  def install
    ENV.prepend_create_path "PYTHONPATH", "#{libexec}/lib/python2.7/site-packages"
    %w[slowaes pbkdf2 requests pyasn pyasn1modules qrcode socksipy tlslite pycurl].each do |r|
      resource(r).stage do
        pyargs = ["setup.py", "install", "--prefix=#{libexec}"]
          unless %w[socksipy tlslite pycurl].include? r
            pyargs << "--single-version-externally-managed" << "--record=installed.txt"
          end
        system "python", *pyargs
      end
    end
    system "python", "mki18n.py"
    system "pyrcc4", "icons.qrc", "-o", "gui/qt/icons_rc.py"
    system "python", "setup.py", "install", "--prefix=#{prefix}",
           "--single-version-externally-managed", "--record=installed.txt"

    bin.env_script_all_files(libexec+"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end

  def caveats; <<-EOS.undent
    To finish installation you must do:
      sudo pip install ecdsa
    EOS
  end
end
