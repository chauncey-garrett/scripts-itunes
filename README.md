# Scripts for iTunes

A curated collection of scripts (including AppleScripts) that I have either made and/or commandeered for iTunes.

# Installation

Fork the repo then install with:

```
git clone https://github.com/chauncey-garrett/scripts-itunes.git $HOME/Library/iTunes/Scripts
```

If you plan on contributing back to the repository, add the following to `.git/config` **before making any commits.** This code will ensure that the AppleScripts are viewable under version control by decompiling them to plain text before updating the repository.

```
[filter "ascr"]
	clean = "$(git rev-parse --show-toplevel)"/git-ascr-filter.sh --clean %f
	smudge = "$(git rev-parse --show-toplevel)"/git-ascr-filter.sh --smudge %f
```

## Like it?

If you have feature suggestions, please open an [issue](https://github.com/chauncey-garrett/scripts-itunes/issues "chauncey-garrett/scripts-itunes/issues"). If you have contributions, open a [pull request](https://github.com/chauncey-garrett/scripts-itunes/pull-request "chauncey-garrett/scripts-itunes/pulls"). I'd love to expand this library as much as is possible.

## Author(s)

Note that there are scripts here that I did NOT make and have only curated with this repository. If you found a particular script useful, please send your support to that particular author. Appropriate licensing and authorship information is provided for those scripts which I have not written.

*The author(s) of this module should be contacted via the [issue tracker](https://github.com/chauncey-garrett/scripts-itunes/issues "chauncey-garrett/scripts-itunes/issues").*

  - [Chauncey Garrett](https://github.com/chauncey-garrett "chauncey-garrett")

[![](/img/tip.gif)](http://chauncey.io/about/index.html#tip)
