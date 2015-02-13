Formula Descriptions
===============

* bitcoind - The Bitcoin Client. GUI Optional. Currently building against Qt4 but will be switched to Qt5 in the near future.

* bopenssh - OpenSSH, builds using LibreSSL instead of OpenSSL.

* boringssl - Google’s SSL Library.

* copenssl - OpenSSL. Same formula as in Homebrew/Homebrew, except this one disables IDEA and SSLv3 by default.

* deluge - Popular open-source bittorrent client. Debian distributes itself optionally through Torrent links - Torrenting in itself is not a crime, I am not facilitating crime. If you think I am, get a grip.

* dogecoin - Dogecoin Client. GUI Optional.

* electrum - Popular “Lite” Bitcoin Wallet.

* gnu-wget - Same formula as in Homebrew/Homebrew, except this builds against LibreSSL rather than OpenSSL. Consequently, unless you choose otherwise with the applicable option, the binary is called `lwget` to prevent conflict with the normal `wget`.

* mosmans-openssl - Peter Mosman’s OpenSSL fork with enabled ChaCha20 & Poly1305 support. Based off the 1.0.2-stable branch.

* poly1305aes - Implementation of Poly1305 for MAC released into the public domain by D. J. Bernstein.

* qbittorrent - Popular Bittorrent client. Not super-stable yet; waiting on the next release to fix several outstanding major issues.

* secp256k1 - Bitcoin’s experimental curves library.

* truecrypt - My fork of the 7.1a Truecrypt source code. All modifications, of which there are none to the source code itself, are documented by commits in the upstream repo.


**Standard Boring Disclaimer**

Although I’ve glanced over both Peter Mosman’s OpenSSL changes and Cloudflare’s ChaCha-Poly patch, I hate C with a burning passion and have yet to muster the courage to learn it to an acceptable level; Thus, don’t presume that because they are included here they are “safe”. That determination is your’s to make, not mine.

The same applies more broadly to the entire repo. Be paranoid. Check things yourself. Decide what to trust from your own determination. You can see all the changes I’ve made to the formulae through commits, but you may wish to (and should) check any patches used in addition.
