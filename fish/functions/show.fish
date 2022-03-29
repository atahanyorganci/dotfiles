function show --wraps "git show" --description "Git Show - Show various types of objects and defaults to summary"
    if test (count $argv) -gt 0
        command git show $argv
    else
        command git show --compact-summary HEAD
    end
end
