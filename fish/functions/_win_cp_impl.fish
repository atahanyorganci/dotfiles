function _win_cp_impl --argument src dest
    if not test -e $src
        set src (realpath "$WIN_HOME/$src")
    end
    if test -d $src
        set -l contents (cp -r -v $src $dest | awk '{ print substr($3, 2, length($3) - 2); }')
        for content in $contents
            win_chmod $content
        end
    else
        set -l file (cp -v $src $dest | awk '{ print substr($3, 2, length($3) - 2); }')
        win_chmod $file
    end
end
