#!/usr/bin/env fish

set -U EDITOR code

function gc --wraps "git commit" --description "git commit"
    command git commit $argv
end

function ga --wraps "git add" --description "git add"
    if test (count $argv) -gt 0
        command git add $argv
    else
        command git add .
    end
end

function gl --wraps "git log" --description "git log"
    if test (count $argv) -gt 0
        command git log $argv
    else
        command git log --oneline --pretty=format:'%Cgreen(%cr)%Creset %Cred%h%Creset %s'
    end
end

function lb
    command latexmk -Werror -pdf -halt-on-error $argv
end

function lbc
    command latexmk -Werror -pdf -halt-on-error $argv
    command latexmk -c
end

function lc
    command latexmk -Werror -c $argv
end

function tree
    command exa --tree --git-ignore $argv
end

function ll
    command exa -l --git-ignore $argv
end

function fish_title
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

set -U OS (os)

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

# Configure CARGO_HOME, RUSTUP_HOME and add cargo binaries to PATH
set -Ux CARGO_HOME $XDG_DATA_HOME/cargo
set -Ux RUSTUP_HOME $XDG_DATA_HOME/rustup
fish_add_path $CARGO_HOME/bin

check_update
eval (starship init fish)
set fish_greeting

# Created by `pipx`
fish_add_path $HOME/.local/bin

# Add `SCRIPTLY_ROOT` variable for `scriptly`
set -Ux SCRIPTLY_ROOT $HOME/Development/tools

# Optout of the .NET telementry
set -Ux DOTNET_CLI_TELEMETRY_OPTOUT 1

# Configure `fzf.fish` keybindings
fzf_configure_bindings
fzf_configure_bindings --git_log=\cg

# Set GOPATH
set -Ux GOPATH $XDG_DATA_HOME/go
fish_add_path $GOPATH/bin
