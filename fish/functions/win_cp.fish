function win_cp --description "Copy over files from Windows FS to WSL"
    set -l arg_count (count $argv)
    if test $arg_count -lt 2
        echo "Usage: win_cp SOURCE DEST"
        echo "   or: win_cp SOURCE... DIRECTORY"
        echo "Copy SOURCE to DEST where SOURCE is on Windows, or multiple SOURCE(s) to DIRECTORY."
        return 1
    end
    set -l srcs $argv[1..(math $arg_count - 1)]
    set -l dest $argv[$arg_count]
    if test (count $srcs) -gt 1
        if test ! -d $dest
            echo "win_cp: destination must be a directory when copying multiple files/directories"
            return 1
        end
        for src in $srcs
            _win_cp_impl $src $dest
        end
        win_chmod $dest
    else
        _win_cp_impl $srcs[1] $dest
    end
end
