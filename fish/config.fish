#!/usr/bin/env fish

set -U EDITOR code


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

# Add exectuables installed by cargo to the PATH
fish_add_path (realpath ~/.cargo/bin/)

# Path to Windows Home
set -U WIN_ROOT /mnt/c
set -U WIN_HOME /mnt/c/Users/Atahan
fish_add_path "/mnt/c/Program Files/Microsoft VS Code/bin"

eval (starship init fish)
set fish_greeting
