<h1 align="center">Punch Card</h1>

<div align="center">

[![GitHub release](https://img.shields.io/github/v/release/koffeinfrei/punch-card.svg?style=flat-square)](https://github.com/koffeinfrei/punch-card/releases)
&nbsp;
[![Build Status](https://img.shields.io/github/workflow/status/koffeinfrei/punch-card/CI.svg?label=CI&style=flat-square)](https://github.com/koffeinfrei/punch-card/actions)
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
$ punch-card start now
$ punch-card stop 12:00
$ punch-card 13:00-17:00
```

### Showing entries

```sh
$ punch-card today
╭──────────────────╮
│ 📅  05.11.2021   │
╰──────────────────╯
╭──────────────────┬──────────────────┬──────────────────╮
│ Entries          │ Total hours      │ Diff             │
├──────────────────┼──────────────────┼──────────────────┤
│ 08:30 - 11:45    │                  │                  │
│ 12:45 - 18:15    │             8:45 │            +0:45 │
╰──────────────────┴──────────────────┴──────────────────╯

$ punch-card 05.11.2021
╭──────────────────╮
│ 📅  05.11.2021   │
╰──────────────────╯
╭──────────────────┬──────────────────┬──────────────────╮
│ Entries          │ Total hours      │ Diff             │
├──────────────────┼──────────────────┼──────────────────┤
│ 08:30 - 11:45    │                  │                  │
│ 12:45 - 18:15    │             8:45 │            +0:45 │
╰──────────────────┴──────────────────┴──────────────────╯

$ punch-card month
╭──────────────────╮
│ 📅  Nov 2021     │
╰──────────────────╯
╭──────────────────┬──────────────────┬──────────────────╮
│ Day              │ Total hours      │ Diff             │
├──────────────────┼──────────────────┼──────────────────┤
│ Mon  01.11.2021  │             8:00 │             0:00 │
│ Tue  02.11.2021  │             8:00 │             0:00 │
│ Wed  03.11.2021  │             7:30 │            -0:30 │
│ Thu  04.11.2021  │             7:00 │            -1:00 │
│ Fri  05.11.2021  │             8:45 │            +0:45 │
╰──────────────────┴──────────────────┴──────────────────╯
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
# bump the major version, e.g. from 1.2.0 to 2.2.0
$ scripts/version bump:major

# bump the minor version, e.g. from 1.2.0 to 1.3.0
$ scripts/version bump:minor

# bump the patch version, e.g. from 1.2.0 to 1.2.1
$ scripts/version bump:patch
```

---

Made with ☕️  by [Koffeinfrei](https://github.com/koffeinfrei)
