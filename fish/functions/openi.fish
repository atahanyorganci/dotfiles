function openi --description "Open a file by choosing interactively"
    set -l arg (ll $argv | fzf --prompt="open " | awk '{print $7}')
    if test $status != 0 -o "$arg" = ""
        return 1
    end
    open $arg
end
