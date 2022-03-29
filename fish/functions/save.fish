function save -w funcsave -d "Save function to functions directory and update .gitignore"
    set -l functions "$__fish_config_dir/functions"
    set -l ignore "$functions/.gitignore"
    for arg in $argv
        set -l path "$functions/$arg.fish"
        echo "!$arg.fish" >>$ignore
        funcsave $arg
        fish_indent -w $path
        set -l path (realpath --relative-to $HOME $path)
        echo "Saved `$arg` to '~/$path'"
    end
end
