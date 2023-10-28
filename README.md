<h1 align="center">Punch Card</h1>

<div align="center">

![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/koffeinfrei/punch-card?color=lightblue&label=version&sort=semver&style=flat-square)
&nbsp;
[![Build Status](https://img.shields.io/github/actions/workflow/status/koffeinfrei/punch-card/ci.yml?branch=main&label=CI&style=flat-square)](https://github.com/koffeinfrei/punch-card/actions)
&nbsp;
![License](https://img.shields.io/github/license/koffeinfrei/punch-card.svg?style=flat-square)

</div>

> I needed a simple tool to track my work time. This is exactly what I was looking for.<br> -- myself

<br>

<div align="center">

This is a simple CLI to track your work time.

<img src="./punch-card.webp" />

</div>

<br>

## Usage

### Adding entries

```sh
# Adding entries for today
$ punch-card start now
$ punch-card stop 12:00
$ punch-card 13:00-17:00
$ punch-card punch

# Adding entries for an arbitrary day
$ punch-card start 09:00 12.12.2021
$ punch-card stop 12:00 12.12.2021
$ punch-card 13:00-17:00 12.12.2021
```

### Showing entries

```sh
$ punch-card today
╭──────────────────╮
│ 📅  05.11.2021   │
╰──────────────────╯
╭──────────────────┬──────────────────┬──────────────────┬──────────────────╮
│ Entries          │ Total hours      │ Diff             │ Project          │
├──────────────────┼──────────────────┼──────────────────┼──────────────────┤
│ 08:30 - 11:45    │                  │                  │                  │
│ 12:45 - 18:15    │             8:45 │            +0:45 │                  │
╰──────────────────┴──────────────────┴──────────────────┴──────────────────╯

$ punch-card 05.11.2021
╭──────────────────╮
│ 📅  05.11.2021   │
╰──────────────────╯
╭──────────────────┬──────────────────┬──────────────────┬──────────────────╮
│ Entries          │ Total hours      │ Diff             │ Project          │
├──────────────────┼──────────────────┼──────────────────┼──────────────────┤
│ 08:30 - 11:45    │                  │                  │ Project A        │
│ 12:45 - 18:15    │             8:45 │            +0:45 │ Project B        │
╰──────────────────┴──────────────────┴──────────────────┴──────────────────╯

$ punch-card month
╭──────────────────╮
│ 📅  Nov 2021     │
╰──────────────────╯
╭──────────────────┬──────────────────┬──────────────────┬──────────────────╮
│ Day              │ Total hours      │ Diff             │ Projects         │
├──────────────────┼──────────────────┼──────────────────┼──────────────────┤
│ Mon  01.11.2021  │             8:00 │             0:00 │                  │
│ Tue  02.11.2021  │             8:00 │             0:00 │                  │
│ Wed  03.11.2021  │             7:30 │            -0:30 │                  │
│ Thu  04.11.2021  │             7:00 │            -1:00 │                  │
│ Fri  05.11.2021  │             8:45 │            +0:45 │                  │
╰──────────────────┴──────────────────┴──────────────────┴──────────────────╯
╭──────────────────┬──────────────────┬──────────────────╮
│ Total            │            39:15 │            -0:45 │
╰──────────────────┴──────────────────┴──────────────────╯
```

## Installation

### Install from snap

```bash
sudo snap install punch-card
```

### Install from source

First you'll need to [install
Crystal](https://crystal-lang.org/reference/installation/).

 ```bash
 $ git clone git@github.com:koffeinfrei/punch-card.git
 $ cd punch-card
 $ shards build --release
 $ cp bin/punch-card <some directory in your $PATH>
 ```

## Contributing

1. Fork it (<https://github.com/koffeinfrei/punch-card/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

### Versioning

[Semantic Versioning](https://semver.org/) is used, obviously.

There's a script that bumps the version in all necessary files and creates a
git tag.

```bash
# bump the major version, e.g. from 1.2.0 to 2.0.0
$ scripts/version bump:major

# bump the minor version, e.g. from 1.2.0 to 1.3.0
$ scripts/version bump:minor

# bump the patch version, e.g. from 1.2.0 to 1.2.1
$ scripts/version bump:patch
```

### Build snap

```bash
$ snapcraft
...
Snapped punch-card_<version>_amd64.snap

$ snapcraft upload punch-card_<version>_amd64.snap
...
Revision <revision> created for 'punch-card'

$ snapcraft release punch-card <revision> candidate
$ snapcraft release punch-card <revision> stable
```

---

Made with ☕️  by [Koffeinfrei](https://github.com/koffeinfrei)
