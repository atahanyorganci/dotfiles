#!/usr/bin/env fish

function fish_title --description "Set terminal title"
    if set -q argv[1]
        set -l arg $argv[1]
        echo "[$arg] @ "
    end
    set -l escaped (string replace -a "/" "\/" $HOME)
    if string match -rq "$escaped(?<path>.*)" $PWD
        echo "~$path"
    else
        echo $PWD
    end
end

function c --description "Visiual Studio Code" --wraps code
    if test (count $argv) -gt 0
        command code $argv
    else
        command code .
    end
end

set -Ux EDITOR code
set -Ux DEV_HOME $HOME/Documents

# XDG Base Directory Specification
set -Ux XDG_CONFIG_HOME $HOME/.config
set -Ux XDG_DATA_HOME $HOME/.local/share
set -Ux XDG_CACHE_HOME $HOME/.cache
set -Ux XDG_STATE_HOME $HOME/.local/state

# OS dependent configurations
switch $OS
    case Darwin
        # Initialize Homebrew
        /opt/homebrew/bin/brew shellenv | source
    case WSL
        # Add WIN_ROOT and WIN_HOME to WSL environment
        set -Ux WIN_ROOT /mnt/c
        set -Ux WIN_HOME /mnt/c/Users/Atahan
        fish_add_path "$WIN_ROOT/Program Files/Microsoft VS Code/bin"
end

# Add .local/bin to `PATH`
mkdir -p "$HOME/.local/bin"
fish_add_path "$HOME/.local/bin"

# Export `CARGO_HOME` and `RUSTUP_HOME`
set -Ux CARGO_HOME $XDG_DATA_HOME/cargo
set -Ux RUSTUP_HOME $XDG_DATA_HOME/rustup
fish_add_path "$CARGO_HOME/bin"

# Set fish prompt and greeting
eval (starship init fish)
set fish_greeting

# Optout of the .NET telementry
set -Ux DOTNET_CLI_TELEMETRY_OPTOUT 1

# Configure `fzf.fish` keybindings
fzf_configure_bindings
fzf_configure_bindings --git_log=\cg

# Move `.node_repl_history` to `XDG_STATE_HOME`
set -Ux NODE_REPL_HISTORY $XDG_STATE_HOME/node_repl_history

# Execute startup script to change .python_history's location
set -Ux PYTHONSTARTUP $XDG_CONFIG_HOME/python/startup.py
set -Ux PYTHONHISTFILE $XDG_STATE_HOME/python/history

# Configure kitty
set -l KITTY_CONFIG_DIRECTORY $XDG_CONFIG_HOME/kitty
set -l KITTY_CACHE_DIRECTORY $XDG_CACHE_HOME/kitty

# User data dir for pandoc contains templates
set -Ux PANDOC_DATA_DIR (pandoc -v | grep data | awk -F: '{ gsub(/ /,""); print $2; }')

# Fly.io CLI
set -Ux FLY_INSTALL "$XDG_DATA_HOME/fly"
fish_add_path "$FLY_INSTALL/bin" $PATH

# `mise` development tool manager
if not set -q IN_NIX_SHELL
    mise activate fish | source
end

set -Ux DOCKER_CONFIG_HOME "$XDG_CONFIG_HOME/docker"
set -Ux WGETRC "$XDG_CONFIG_HOME/wgetrc"
alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"
