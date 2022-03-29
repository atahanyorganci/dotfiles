function doc_functions -d "Generate markdown documentation for all user-defined functions"
    set -f file_functions (git ls-tree -r main --name-only | grep "fish/functions" | sed "s/fish\/functions\///" | sed "s/.fish//")
    printf "# Functions\n\n"
    for fn in (functions)
        set -l is_file (contains $fn $file_functions && echo "true" || echo "false")
        set -l path (functions -D $fn)
        if test $is_file != true -a $path != "$__fish_config_dir/config.fish"
            continue
        end
        set -l src (functions $fn)
        string match -qr '.*((description)|d)( |=)("|\')(?<desc>[^"\']*)\4.*' $src
        string match -qr '.*((wraps)|w)( |=)("|\')(?<wrap>[^"\']*)\4.*' $src
        echo -ne "- `$fn`"
        if test -n "$wrap"
            echo -ne " (`$wrap`)"
        end
        if test -n "$desc"
            echo ": $desc"
        else
            echo
        end
    end
end
