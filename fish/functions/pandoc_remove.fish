function pandoc_remove --description "Uninstall pandoc template"
    argparse --name=pandoc_remove h/help f/force d/dry -- $argv
    or return
    set -f usage "USAGE: pandoc_remove [OPTIONS] [FILE]..."
    if set -q _flag_h
        echo "pandoc_remove: Uninstall pandoc template from `PANDOC_DATA_DIR`"
        echo ""
        echo $usage
        echo ""
        echo "OPTIONS:"
        echo "  -f/--force: force remove files"
        echo "  -d/--dry: dry run, print commands without executing"
        echo "  -h/--help: print this message"
        return
    end
    if test (count $argv) -eq 0
        echo "pandoc_remove: missing argument"
        echo ""
        echo $usage
        return
    end
    if set -q _flag_f
        set -f flags -f
    end
    set -f files
    for file in $argv
        set -f files $files $PANDOC_DATA_DIR/templates/$file
    end
    set -f cmd rm $flags $files
    if set -q _flag_d
        echo $cmd
    else
        command $cmd
    end
end
