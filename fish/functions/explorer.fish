function explorer --description "Windows Explorer"
    set -l cmd "$WIN_ROOT/Windows/explorer.exe"
    if test (count $argv) = 0
        command $cmd .
    else
        command $cmd $argv
    end
end
