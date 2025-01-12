class Deluge < Formula
  include Language::Python::Virtualenv

  desc "Popular open-source bittorrent client"
  homepage "https://deluge-torrent.org/"
  url "https://files.pythonhosted.org/packages/00/d7/8673068046ded6eaa82caaa2afd6f0751faf591aab5ad150aeafe0d47cb3/deluge-2.1.1.tar.gz"
  sha256 "d6ea7e1f5bdd75f40cbd1d56f0c97cd1b5b74bc9e03783858c7daa81063dd4b9"
  revision 1
  head "https://git.deluge-torrent.org/deluge", branch: "develop"

  depends_on "intltool" => :build
  depends_on "rust" => :build # For cryptography
  depends_on "boost-python3"
  depends_on "freetype"
  depends_on "gettext"
  depends_on "gtk-mac-integration"
  depends_on "librsvg"
  depends_on "libtorrent-rasterbar"
  depends_on "openssl"
  depends_on "py3cairo"
  depends_on "pygobject3"
  depends_on "python@3.13" # Must match with libtorrent-rasterbar

  resource "attrs" do
    url "https://files.pythonhosted.org/packages/48/c8/6260f8ccc11f0917360fc0da435c5c9c7504e3db174d5a12a1494887b045/attrs-24.3.0.tar.gz"
    sha256 "8f5c07333d543103541ba7be0e2ce16eeee8130cb0b3f9238ab904ce1e85baff"
  end

  resource "Automat" do
    url "https://files.pythonhosted.org/packages/8d/2d/ede4ad7fc34ab4482389fa3369d304f2fa22e50770af706678f6a332fa82/automat-24.8.1.tar.gz"
    sha256 "b34227cf63f6325b8ad2399ede780675083e439b20c323d376373d8ee6306d88"
  end

  resource "cffi" do
    url "https://files.pythonhosted.org/packages/fc/97/c783634659c2920c3fc70419e3af40972dbaf758daa229a7d6ea6135c90d/cffi-1.17.1.tar.gz"
    sha256 "1c39c6016c32bc48dd54561950ebd6836e1670f2ae46128f67cf49e789c52824"
  end

  resource "constantly" do
    url "https://files.pythonhosted.org/packages/4d/6f/cb2a94494ff74aa9528a36c5b1422756330a75a8367bf20bd63171fc324d/constantly-23.10.4.tar.gz"
    sha256 "aa92b70a33e2ac0bb33cd745eb61776594dc48764b06c35e0efd050b7f1c7cbd"
  end

  resource "cryptography" do
    url "https://files.pythonhosted.org/packages/91/4c/45dfa6829acffa344e3967d6006ee4ae8be57af746ae2eba1c431949b32c/cryptography-44.0.0.tar.gz"
    sha256 "cd4e834f340b4293430701e772ec543b0fbe6c2dea510a5286fe0acabe153a02"
  end

  resource "hyperlink" do
    url "https://files.pythonhosted.org/packages/3a/51/1947bd81d75af87e3bb9e34593a4cf118115a8feb451ce7a69044ef1412e/hyperlink-21.0.0.tar.gz"
    sha256 "427af957daa58bc909471c6c40f74c5450fa123dd093fc53efd2e91d2705a56b"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/f1/70/7703c29685631f5a7590aa73f1f1d3fa9a380e654b86af429e0934a32f7d/idna-3.10.tar.gz"
    sha256 "12f65c9b470abda6dc35cf8e63cc574b1c52b11df2c86030af0ac09b01b13ea9"
  end

  resource "incremental" do
    url "https://files.pythonhosted.org/packages/27/87/156b374ff6578062965afe30cc57627d35234369b3336cf244b240c8d8e6/incremental-24.7.2.tar.gz"
    sha256 "fb4f1d47ee60efe87d4f6f0ebb5f70b9760db2b2574c59c8e8912be4ebd464c9"
  end

  resource "Mako" do
    url "https://files.pythonhosted.org/packages/5f/d9/8518279534ed7dace1795d5a47e49d5299dd0994eed1053996402a8902f9/mako-1.3.8.tar.gz"
    sha256 "577b97e414580d3e088d47c2dbbe9594aa7a5146ed2875d4dfa9075af2dd3cc8"
  end

  resource "MarkupSafe" do
    url "https://files.pythonhosted.org/packages/b2/97/5d42485e71dfc078108a86d6de8fa46db44a1a9295e89c5d6d4a06e23a62/markupsafe-3.0.2.tar.gz"
    sha256 "ee55d3edf80167e48ea11a923c7386f4669df67d7994554387f84e7d8b0a2bf0"
  end

  resource "pyasn1" do
    url "https://files.pythonhosted.org/packages/ba/e9/01f1a64245b89f039897cb0130016d79f77d52669aae6ee7b159a6c4c018/pyasn1-0.6.1.tar.gz"
    sha256 "6f580d2bdd84365380830acf45550f2511469f673cb4a5ae3857a3170128b034"
  end

  resource "pyasn1-modules" do
    url "https://files.pythonhosted.org/packages/1d/67/6afbf0d507f73c32d21084a79946bfcfca5fbc62a72057e9c23797a737c9/pyasn1_modules-0.4.1.tar.gz"
    sha256 "c28e2dbf9c06ad61c71a075c7e0f9fd0f1b0bb2d2ad4377f240d33ac2ab60a7c"
  end

  resource "pycparser" do
    url "https://files.pythonhosted.org/packages/1d/b2/31537cf4b1ca988837256c910a668b553fceb8f069bedc4b1c826024b52c/pycparser-2.22.tar.gz"
    sha256 "491c8be9c040f5390f5bf44a5b07752bd07f56edf992381b05c701439eec10f6"
  end

  resource "pyOpenSSL" do
    url "https://files.pythonhosted.org/packages/9f/26/e25b4a374b4639e0c235527bbe31c0524f26eda701d79456a7e1877f4cc5/pyopenssl-25.0.0.tar.gz"
    sha256 "cd2cef799efa3936bb08e8ccb9433a575722b9dd986023f1cabc4ae64e9dac16"
  end

  resource "pyxdg" do
    url "https://files.pythonhosted.org/packages/b0/25/7998cd2dec731acbd438fbf91bc619603fc5188de0a9a17699a781840452/pyxdg-0.28.tar.gz"
    sha256 "3267bb3074e934df202af2ee0868575484108581e6f3cb006af1da35395e88b4"
  end

  resource "rencode" do
    url "https://files.pythonhosted.org/packages/3a/fb/3c03dbe4438dd596e1378b5299990b81041739658a76e0f4a301eded67f4/rencode-1.0.6.tar.gz"
    sha256 "2586435c4ea7d45f74e26765ad33d75309de7cf47c4d762e8efabd39905c0718"
  end

  resource "service-identity" do
    url "https://files.pythonhosted.org/packages/07/a5/dfc752b979067947261dbbf2543470c58efe735c3c1301dd870ef27830ee/service_identity-24.2.0.tar.gz"
    sha256 "b8683ba13f0d39c6cd5d625d2c5f65421d6d707b013b375c355751557cbe8e09"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/94/e7/b2c673351809dca68a0e064b6af791aa332cf192da575fd474ed7d6f16a2/six-1.17.0.tar.gz"
    sha256 "ff70335d468e7eb6ec65b95b99d3a2836546063f63acc5171de367e834932a81"
  end

  resource "tomli" do
    url "https://files.pythonhosted.org/packages/18/87/302344fed471e44a87289cf4967697d07e532f2421fdaf868a303cbae4ff/tomli-2.2.1.tar.gz"
    sha256 "cd45e1dc79c835ce60f7404ec8119f2eb06d38b1deba146f07ced3bbc44505ff"
  end

  resource "Twisted" do
    url "https://files.pythonhosted.org/packages/77/1c/e07af0df31229250ab58a943077e4adbd5e227d9f2ac826920416b3e5fa2/twisted-24.11.0.tar.gz"
    sha256 "695d0556d5ec579dcc464d2856b634880ed1319f45b10d19043f2b57eb0115b5"
  end

  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/df/db/f35a00659bc03fec321ba8bce9420de607a1d37f8342eee1863174c69557/typing_extensions-4.12.2.tar.gz"
    sha256 "1a7ead55c7e559dd4dee8856e3a88b41225abfe1ce8df57b7c13915fe121ffb8"
  end

  resource "zope.interface" do
    url "https://files.pythonhosted.org/packages/30/93/9210e7606be57a2dfc6277ac97dcc864fd8d39f142ca194fdc186d596fda/zope.interface-7.2.tar.gz"
    sha256 "8b49f1a3d1ee4cdaf5b32d2e738362c7f5e40ac8b46dd7d1a65e82a4872728fe"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    pid = fork do
      exec "#{bin}/deluge-web --port=8081"
    end
    sleep 2

    begin
      assert_match "Deluge WebUI #{version}", shell_output("curl localhost:8081 2>&1")
    ensure
      Process.kill("SIGINT", pid)
      Process.wait(pid)
    end
  end
end
