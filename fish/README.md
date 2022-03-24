# Fish Config

Configuration for [fish-shell](https://github.com/fish-shell/fish-shell/), feel free to use and redistribute!

## Getting Started

### Fish Plugings

This setup requires following fish plugins to work
- [`fisher`](https://github.com/jorgebucaran/fisher) plugin manager for installing and removing plugins
- [`pisces`](https://github.com/laughedelic/pisces) inserts matching quotes like VS Code
- [`z`](https://github.com/jethrokuan/z) keeps track of frequently visited directories

```sh
# install fisher
$ curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
# install fish plugins
$ fisher install laughedelic/pisces jethrokuan/z
```

### Commandline Tools

Required packages
- [`peco`](https://github.com/peco/peco) for interactive filtering tool
- [`bat`](https://github.com/sharkdp/bat) modern alternative to `cat` with syntax highlighting
- [`exa`](https://github.com/ogham/exa) modern replacement for `ls` with `.gitignore` support
