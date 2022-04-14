function pandoc_add --description "Install pandoc template"
    argparse --name=pandoc_add h/help f/force d/dry -- $argv
    or return
    set -f usage "USAGE: pandoc_add [OPTIONS] [FILE]..."
    if set -q _flag_h
        echo "pandoc_add: Install pandoc template to `PANDOC_DATA_DIR`"
        echo ""
        echo $usage
        echo ""
        echo "OPTIONS:"
        echo "  -f/--force: overwrite existing files"
        echo "  -d/--dry: dry run, print commands without executing"
        echo "  -h/--help: print this message"
        return
    end
    if test (count $argv) -eq 0
        echo "pandoc_add: missing argument"
        echo ""
        echo $usage
        return
    end
    if set -q _flag_f
        set -f flags -f
    end
    set -f TEMPLATE_DIR $PANDOC_DATA_DIR/templates
    mkdir -p $TEMPLATE_DIR
    set -f cmd cp $flags $argv $TEMPLATE_DIR
    if set -q _flag_d
        echo $cmd
    else
        command $cmd
    end
end
