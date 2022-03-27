# `zsh` Config

## How I choose where to put a setting

- if it is needed by a **command run non-interactively**: `.zshenv`
- if it should be **updated on each new shell**: `.zshenv`
- if it runs a command which **may take some time to complete**: `.zprofile`
- if it is related to **interactive usage**: `.zshrc`
- if it is a **command to be run when the shell is fully setup**: `.zlogin`
- if it **releases a resource** acquired at login: `.zlogout`

Taken from this [question][howto] from [Stack Exchange](https://unix.stackexchange.com/).


[howto]: https://unix.stackexchange.com/questions/71253/what-should-shouldnt-go-in-zshenv-zshrc-zlogin-zprofile-zlogout
