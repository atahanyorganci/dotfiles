function confirm --description "Prompt user for confirmation (yes/no)"
    argparse -n confirm -N 1 -X 1 'd/default=?' "s/suffix=?" r/retry -- $argv; or return 1
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
    read -p "echo '$prompt $option$suffix'" -l answer; or return 1
    if test -z "$answer"
        set answer $default
    end
    switch (string lower $answer)
        case y yes
            echo y
        case n no
            echo n
        case "*"
            echo "ERROR: invalid input"
            return 1
    end
end
