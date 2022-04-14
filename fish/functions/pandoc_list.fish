function pandoc_list --description "List installed pandoc templates"
    argparse --name=pandoc_list -X 0 h/help -- $argv
    or return
    if set -q _flag_h
        echo "pandoc_list: Install pandoc template to `PANDOC_DATA_DIR`"
        echo ""
        echo "USAGE: pandoc_list [OPTIONS]"
        echo ""
        echo "OPTIONS:"
        echo "  -h/--help: print this message"
        return
    end
    echo "Installed pandoc templates:"
    for template in (ls -1 $PANDOC_DATA_DIR/templates/*.latex)
        set -l name (basename $template)
        echo "- $name"
    end
end
