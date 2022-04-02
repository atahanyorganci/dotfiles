function _task_should_offer
    set -l names Taskfile.yml Taskfile.yaml Taskfile.dist.yml Taskfile.dist.yaml
    for name in $names
        set -l taskfile $PWD/$name
        if test -f $taskfile
            return 0
        end
    end
    return 1
end
