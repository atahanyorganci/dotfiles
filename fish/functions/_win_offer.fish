function _win_offer
    set -l curr (commandline -t)
    # if current input already exists no need to add $WIN_HOME
    if test -e $curr
        return
    end
    set -l curr "$WIN_HOME/$curr"
    if test -d $curr
        set root "$curr"
    else
        set root (dirname $curr)
    end
    if not test -e $root
        return
    end
    for content in (ls -1 $root)
        set -l path "$root/$content"
        set -l relative (realpath --relative-to $WIN_HOME $path)
        if test -d $path
            echo "$relative/"
        else
            echo "$relative"
        end
    end
end
