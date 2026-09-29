---
hide:
  - navigation
  - toc
---

<div class="lupaxa-hero">
    <img
        class="lupaxa-hero-logo"
        src="assets/images/brand/the-lupaxa-project-hero-logo.png"
        alt="The Lupaxa Project Logo"
        translate="no"/>
    <h1 class="lupaxa-hero-title" translate="no">
        Homebrew Tap
    </h1>

    <p class="lupaxa-hero-subtitle">
        Homebrew formulae for The Lupaxa Project tools. One formula points at one tagged
        release of that tool's own repository.
    </p>
</div>

<!-- lupaxa-article-card -->

# Usage

This tap publishes one Homebrew formula for each tagged Lupaxa Project tool. Add the
tap, install what you need, then use the commands below to list, update, and
remove formulae. Worked examples follow. The full command list is at the end.

## Setup

Add this tap and trust it.

### Requirements

- Homebrew
- On Homebrew 7, trust the tap before the first install

Homebrew 7 will not install from a third-party tap until that tap is trusted.

### Install

```bash
brew tap the-lupaxa-project/tap
brew trust the-lupaxa-project/tap
```

### First Run

List what the tap publishes:

```bash
brew tap-info the-lupaxa-project/tap
```

That lists every formula and marks the ones already installed.

## Usage

### List Formulae

```bash
brew tap-info the-lupaxa-project/tap
```

That lists every formula in this tap and marks the ones already installed.

### Update the Tap

```bash
brew update
```

That fetches the newest formulae for this tap. To install newer versions of
formulae you already have:

```bash
brew upgrade
```

### If Update Fetch Fails

Tapping this repo before its first commit makes `brew update` look for a
`main` branch. The tap's branch is `master`, so the update prints
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

## Examples

Replace `<formula>` with the formula you want. The other commands assume
this tap is already added and trusted.

### Install a Formula

```bash
brew install <formula>
```

Repeat `brew install` for each extra formula.

### Inspect Formulae

```bash
brew tap-info the-lupaxa-project/tap
brew info <formula>
```

`brew tap-info` lists every formula in the tap and marks the ones already
installed. `brew info` shows one formula.

### Upgrade a Formula

```bash
brew update
brew upgrade <formula>
```

`brew update` fetches newer formula definitions. `brew upgrade` without a
name upgrades every outdated formula you already have.

### Uninstall a Formula

```bash
brew uninstall <formula>
```

That removes the installed formula. The tap stays in place.

### Remove the Tap

```bash
brew untap the-lupaxa-project/tap
```

That removes the tap. Formulae you already installed stay installed.

## Reference

### Commands

| Command                                | What it Does                                        |
| -------------------------------------- | --------------------------------------------------- |
| `brew tap the-lupaxa-project/tap`      | Add this tap                                        |
| `brew trust the-lupaxa-project/tap`    | Allow Homebrew 7 to install from this tap           |
| `brew install <formula>`               | Install one formula from the tap                    |
| `brew info <formula>`                  | Show one formula                                    |
| `brew tap-info the-lupaxa-project/tap` | List formulae and mark the ones already installed   |
| `brew update`                          | Fetch newer formula definitions                     |
| `brew upgrade`                         | Upgrade every outdated formula you already have     |
| `brew upgrade <formula>`               | Upgrade one installed formula                       |
| `brew uninstall <formula>`             | Remove one installed formula                        |
| `brew untap the-lupaxa-project/tap`    | Remove the tap                                      |
