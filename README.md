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
