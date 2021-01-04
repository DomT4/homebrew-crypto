class GoRequirement < Requirement
  fatal true

  satisfy(build_env: false) { which("go") }

  def message
    <<~EOS
      git-max requires golang to compile:
        brew install go
    EOS
  end
end

class GitMax < Formula
  desc "Distributed revision control system"
  homepage "https://git-scm.com"
  url "https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.30.0.tar.xz"
  sha256 "55735021109565721af805af382c45cce73c3cfaa59daad22443d1477d334d19"
  head "https://github.com/git/git.git", shallow: false

  bottle do
    root_url "https://dl.bintray.com/domt4/crypto-bottles"
    sha256 "ef72ba212e4d41dd5d17c07b467a1840d3f617ed98a4a9fb6cb6a330214162c3" => :big_sur
  end

  depends_on GoRequirement => :build
  depends_on "openssl@1.1"
  depends_on "pcre2"
  depends_on "domt4/crypto/curl-max" => :recommended
  depends_on "gettext" => :recommended
  # So bindings can be found & used by Homebrew's Perl.
  depends_on "perl" => :recommended
  depends_on "tcl-tk" => :recommended
  depends_on "subversion" => :optional

  conflicts_with "git",
    because: "git-max is a feature-heavy version of the git formula"
  conflicts_with "git-gui",
    because: "git-max installs the Tcl/Tk UI by default"

  resource "html" do
    url "https://mirrors.edge.kernel.org/pub/software/scm/git/git-htmldocs-2.30.0.tar.xz"
    sha256 "820132c62ade3df12b4178857cfc5c92276b847b2307a5f7f4d24c27774f962f"
  end

  resource "man" do
    url "https://mirrors.edge.kernel.org/pub/software/scm/git/git-manpages-2.30.0.tar.xz"
    sha256 "7b2b8405d5bdd149e3891617053de37f7e8d5a5b3834317a5af9f30ccc93cf76"
  end

  def install
    # If these things are installed, tell Git build system not to use them
    ENV["NO_FINK"] = "1"
    ENV["NO_DARWIN_PORTS"] = "1"
    ENV["DC_SHA1"] = "1"
    ENV["V"] = "1" # build verbosely
    ENV["INSTALL_SYMLINKS"] = "1"
    ENV["SOURCE_DATE_EPOCH"] = "1"
    ENV["PYTHON_PATH"] = which("python")
    ENV["PERL_PATH"] = which("perl")

    perl_version = Utils.safe_popen_read("perl", "--version")[/v(\d+\.\d+)(?:\.\d+)?/, 1]
    # If building with a non-system Perl search everywhere declared in @INC.
    perl_inc = Utils.safe_popen_read("perl -e 'print join\":\",@INC'").sub(":.", "")

    if build.with? "subversion"
      ENV["PERLLIB_EXTRA"] = %W[
        #{Formula["subversion"].opt_lib}/perl5/site_perl
      ].join(":")
    elsif build.with? "perl"
      ENV["PERLLIB_EXTRA"] = perl_inc
    elsif MacOS.version >= :mavericks
      ENV["PERLLIB_EXTRA"] = %W[
        #{MacOS.active_developer_dir}
        /Library/Developer/CommandLineTools
        /Applications/Xcode.app/Contents/Developer
      ].uniq.map do |p|
        "#{p}/Library/Perl/#{perl_version}/darwin-thread-multi-2level"
      end.join(":")
    end

    ENV["NO_GETTEXT"] = "1" if build.without? "gettext"
    ENV["USE_LIBPCRE2"] = "1"
    ENV["LIBPCREDIR"] = Formula["pcre2"].opt_prefix

    args = %W[
      prefix=#{prefix}
      sysconfdir=#{etc}
      CC=#{ENV.cc}
      CFLAGS=#{ENV.cflags}
      LDFLAGS=#{ENV.ldflags}
      NO_APPLE_COMMON_CRYPTO=1
      OPENSSLDIR=#{Formula["openssl@1.1"].opt_prefix}
    ]

    if build.with? "tcl-tk"
      tcl = Formula["tcl-tk"]
      args << "TKFRAMEWORK=/dev/null"
      args << "TCL_PATH=#{tcl.opt_bin}/tclsh"
      args << "TCLTK_PATH=#{tcl.opt_bin}/wish"
    end

    system "make", "install", *args

    git_core = libexec/"git-core"

    # Install the macOS keychain credential helper
    cd "contrib/credential/osxkeychain" do
      system "make", "CC=#{ENV.cc}",
                     "CFLAGS=#{ENV.cflags}",
                     "LDFLAGS=#{ENV.ldflags}"
      git_core.install "git-credential-osxkeychain"
      system "make", "clean"
    end

    # Generate diff-highlight perl script executable
    cd "contrib/diff-highlight" do
      system "make"
    end

    # Install the netrc credential helper
    cd "contrib/credential/netrc" do
      system "make", "test"
      git_core.install "git-credential-netrc"
    end

    # Install git-subtree
    cd "contrib/subtree" do
      system "make", "CC=#{ENV.cc}",
                     "CFLAGS=#{ENV.cflags}",
                     "LDFLAGS=#{ENV.ldflags}"
      git_core.install "git-subtree"
    end

    cd "contrib/persistent-https" do
      system "make"
      git_core.install "git-remote-persistent-http",
                       "git-remote-persistent-https",
                       "git-remote-persistent-https--proxy"
    end

    # install the completion script first because it is inside "contrib"
    bash_completion.install "contrib/completion/git-completion.bash"
    bash_completion.install "contrib/completion/git-prompt.sh"

    zsh_completion.install "contrib/completion/git-completion.zsh" => "_git"
    cp "#{bash_completion}/git-completion.bash", zsh_completion

    elisp.install Dir["contrib/emacs/*.el"]
    (share/"git-core").install "contrib"

    # We could build the manpages ourselves, but the build process depends
    # on many other packages, and is somewhat crazy, this way is easier.
    man.install resource("man")
    (share/"doc/git-doc").install resource("html")

    # Make html docs world-readable
    chmod 0644, Dir["#{share}/doc/git-doc/**/*.{html,txt}"]
    chmod 0755, Dir["#{share}/doc/git-doc/{RelNotes,howto,technical}"]

    # This is only created when building against system Perl, but it isn't
    # purged by Homebrew's post-install cleaner because that doesn't check
    # "Library" directories. It is however pointless to keep around as it
    # only contains the perllocal.pod installation file.
    rm_rf prefix/"Library/Perl"

    # Set the macOS keychain credential helper by default
    # (as Apple's CLT's git also does this).
    (buildpath/"gitconfig").write <<~EOS
      [credential]
      \thelper = osxkeychain
    EOS
    etc.install "gitconfig"
  end

  test do
    system bin/"git", "init"
    %w[haunted house].each { |f| touch testpath/f }
    system bin/"git", "add", "haunted", "house"
    system bin/"git", "config", "user.name", "wray"
    system bin/"git", "config", "user.email", "wray@example.com"
    system bin/"git", "commit", "-a", "-m", "Initial Commit"
    assert_equal "haunted\nhouse", shell_output("#{bin}/git ls-files").strip
  end
end
