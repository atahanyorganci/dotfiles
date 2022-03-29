#!/usr/bin/env fish

set -l tasks (task --list-all | tail -n +2 | sed 's/* //' | sed "s/:[[:space:]]*/;/")
for task in $tasks
    set -l name (echo $task | awk -F';' '{print $1}')
    set -l desc (echo $task | awk -F';' '{print $2}')
    complete -f --command task -a "$name" -d "$desc"
end
