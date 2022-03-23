function openi --description "Open a file by choosing interactively"
    set -l arg (ll $argv | peco --prompt open --layout bottom-up --on-cancel error | awk '{print $7}')
    if test $status != 0 -o "$arg" = ""
        return 1
    end
    open $arg
end
