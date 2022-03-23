function open --description "Open a file with default app based on mime type"
    argparse -X 1 h/help -- $argv
    if test $status != 0
        return 1
    end
    if test (count $argv) = 0
        explorer .
        return 0
    end
    set -l arg $argv[1]
    if test -d $arg
        explorer $arg
        return 0
    end
    set -l mime (file --mime-type $arg | awk '{ print $2; }')
    switch $mime
        case application/json
            command $EDITOR $arg
        case "application/*xml*"
            command $EDITOR $arg
        case "text/*"
            command $EDITOR $arg
        case '*'
            echo "Unknown mime type '$mime' for '$arg'"
            return 1
    end
end
