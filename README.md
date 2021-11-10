<h1 align="center">Punch Card</h1>

<div align="center">

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
│ 12:45 - 18:15    │             8.75 │            +0.75 │
╰──────────────────┴──────────────────┴──────────────────╯

$ punch-card 05.11.2021
╭──────────────────╮
│ 📅  05.11.2021   │
╰──────────────────╯
╭──────────────────┬──────────────────┬──────────────────╮
│ Entries          │ Total hours      │ Diff             │
├──────────────────┼──────────────────┼──────────────────┤
│ 08:30 - 11:45    │                  │                  │
│ 12:45 - 18:15    │             8.75 │            +0.75 │
╰──────────────────┴──────────────────┴──────────────────╯

$ punch-card month
╭──────────────────╮
│ 📅  Nov 2021     │
╰──────────────────╯
╭──────────────────┬──────────────────┬──────────────────╮
│ Day              │ Total hours      │ Diff             │
├──────────────────┼──────────────────┼──────────────────┤
│ Mon  01.11.2021  │             8.00 │             0.00 │
│ Tue  02.11.2021  │             8.00 │             0.00 │
│ Wed  03.11.2021  │             7.50 │            -0.50 │
│ Thu  04.11.2021  │             7.00 │            -1.00 │
│ Fri  05.11.2021  │             8.75 │            +0.75 │
╰──────────────────┴──────────────────┴──────────────────╯
╭──────────────────┬──────────────────┬──────────────────╮
│ Total            │            39.25 │            -0.75 │
╰──────────────────┴──────────────────┴──────────────────╯
```

## Installation

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

---

Made with ☕️  by [Koffeinfrei](https://github.com/koffeinfrei)
