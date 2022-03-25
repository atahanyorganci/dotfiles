# Fish Config

Configuration for [fish-shell](https://github.com/fish-shell/fish-shell/), feel free to use and redistribute!

## Getting Started

### Fish Plugings

This setup requires following fish plugins to work
- [`fisher`](https://github.com/jorgebucaran/fisher) plugin manager for installing and removing plugins
- [`pisces`](https://github.com/laughedelic/pisces) inserts matching quotes like VS Code
- [`z`](https://github.com/jethrokuan/z) keeps track of frequently visited directories
- [`fzf.fish`](https://github.com/PatrickF1/fzf.fish) augment your fish command line with fzf key bindings

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
- [`fd`](https://github.com/sharkdp/fd) simple, fast and user-friendly alternative to `find`
- [`fzf`](https://github.com/junegunn/fzf) command-line fuzzy finder

### Help

#### `fzf` Key Bindings

`fzf` keybindings can be configured using `fzf_configure_bindings` tool.

| Feature           | Keybinding                  | Option       |
| ----------------- | --------------------------- | ------------ |
| Search directory  | Ctrl+F (F for file)         | --directory  |
| Search git log    | Ctrl+G (G for log)          | --git_log    |
| Search git status | Ctrl+Alt+S (S for status)   | --git_status |
| Search history    | Ctrl+R     (R for reverse)  | --history    |
| Search variables  | Ctrl+V     (V for variable) | --variables  |
| Search processes  | Ctrl+Alt+P (P for process)  | --processes  |

**Note:** This configuration isn't the default run following commands to configure `fzf`.
```sh
$ fzf_configure_bindings --directory=\cf # bind search dir to Ctrl+F
$ fzf_configure_bindings --git_log=\cg # bind searching git log to Ctrl+G
```
