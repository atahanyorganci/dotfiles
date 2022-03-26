function confirm
    argparse -n confirm -N 1 -X 1 'd/default=?' "s/suffix=?" r/retry -- $argv
    if test $status != 0
        echo "WRONG BITCH!"
    end
    set prompt $argv[1]
    switch "$_flag_default"
        case y Y
            set default y
            set option "[Y/n]"
        case n N ""
            set option "[y/N]"
            set default n
        case "*"
            echo "ERROR: invalid default value '$_flag_default'"
            return 1
    end
    if test -n "$_flag_suffix"
        set suffix $_flag_suffix
    else
        set suffix ": "
    end
    read -p "echo '$prompt $option$suffix'" -l answer
    if test -z "$answer"
        set answer $default
    end
    switch "$answer"
        case y Y
            return 0
        case n N
            return 1
        case "*"
            echo "ERROR: invalid input"
            return 1
    end
end
