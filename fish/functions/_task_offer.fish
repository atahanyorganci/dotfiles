function _task_offer
    set -f tasks (task --list-all | tail -n +2 | sed 's/* //' | sed "s/:[[:space:]]*/;/")
    for task in $tasks
        set -f name (echo $task | awk -F';' '{print $1}')
        set -f desc (echo $task | awk -F';' '{print $2}')
        if test -z "$desc"
            set -f desc "No description"
        end
        printf "%s\t%s\n" $name $desc
    end
end
