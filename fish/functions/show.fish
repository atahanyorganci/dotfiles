function show --wraps "git show" --description "git show"
    if test (count $argv) -gt 0
        command git show $argv
    else
        command git show --compact-summary HEAD
    end
end
