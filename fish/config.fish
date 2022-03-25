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

set -U OS (os)

# If configuring fish for Mac OS add brew to PATH
if test $OS = Darwin
    set -U BREW_PREFIX /opt/homebrew
    fish_add_path "$BREW_HOME/bin"
end

# Add exectuables installed by cargo to the PATH
fish_add_path (realpath ~/.cargo/bin/)

# Path to Windows Home
if test $OS = WSL
    set -U WIN_ROOT /mnt/c
    set -U WIN_HOME /mnt/c/Users/Atahan
    fish_add_path "$WIN_ROOT/Program Files/Microsoft VS Code/bin"
end

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
