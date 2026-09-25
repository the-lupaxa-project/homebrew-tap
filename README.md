# Homebrew Tap

Homebrew formulae for Lupaxa tools.

## Install

```bash
brew tap the-lupaxa-project/tap
brew trust the-lupaxa-project/tap
brew install brew-manager
brew install git-reset-history
```

Homebrew 7 will not install from a third-party tap until that tap is trusted.

`brew-manager` is the interactive Homebrew maintenance menu. One formula
points at one tagged release of the tool's own repository.

`git-reset-history` is a Bash CLI to flatten a Git repository to a single
initial commit, with dry-run, backups, and controlled tag handling.

## Available Formulae

```bash
brew tap-info the-lupaxa-project/tap
```

That lists every formula in this tap and marks the ones already installed.

## Update the Tap

```bash
brew update
```

That fetches the newest formulae for this tap. To install newer versions of
formulae you already have:

```bash
brew upgrade
```

## If Update Fetch Fails

Tapping this repo before its first commit makes `brew update` look for a
`main` branch. The tap’s branch is `master`, so the update prints
`Fetching .../homebrew-tap failed!`. Remove the tap and add it again:

```bash
brew untap the-lupaxa-project/tap
brew tap the-lupaxa-project/tap
brew trust the-lupaxa-project/tap
brew update
```

If `brew untap` fails because that checkout is broken:

```bash
rm -rf "$(brew --repository)/Library/Taps/the-lupaxa-project/homebrew-tap"
brew tap the-lupaxa-project/tap
brew trust the-lupaxa-project/tap
```
