function cdi --description "Interactively change directory"
    argparse -X 0 --name=cdi h/help "prompt=?" "layout=?" dry-run -- $argv
    if test $status != 0
        return 1
    end
    if set -q _flag_layout
        set layout $_flag_layout
    else
        set layout bottom-up
    end
    if set -q _flag_prompt
        set prompt $_flag_prompt
    else
        set prompt cd
    end
    set -l dir (z -l | awk '{ print $2; }' | peco --layout $layout --prompt $prompt $filter)
    if set -q _flag_dry_run
        echo "cd $dir"
    else
        cd $dir
    end
end
