homebrew-crypto
===============

Various Cryptographic-Related Formulae.

How do I tap this repository?
--------------------------------
Just `brew tap domt4/crypto`.

It really is that simple. Cool huh.

If you encounter any errors around my repository, do `brew untap domt4/crypto` followed by `brew tap domt4/crypto` and that should sort out any issues. 

Some of the larger pieces of software shipped out of this repository have [bottles](https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Bottles.md) for Yosemite. You can opt-out of using those if desired by building from source with `--build-from-source`, i.e. `brew install foo --build-from-source`. Any OS version older than Yosemite will build from source automatically.

Everything aside `bopenssh` is unbottled at this time. Some formulae, such as `bitcoind`, will never be bottled due to upstream request.

Please feel free to open an issue on this Github if you encounter any errors.