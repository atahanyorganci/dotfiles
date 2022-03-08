function win_chmod --argument-names path --description "Fix permissions on a file or directory copied from Windows FS."
    if test -d $path
        chmod 755 $path
    else
        chmod 644 $path
    end
end
