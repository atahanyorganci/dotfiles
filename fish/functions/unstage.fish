function unstage --wraps "git reset" --description "Unstage files from stage"
    if test (count $argv) -gt 0
        command git reset $argv
    else
        command git reset HEAD .
    end
end
