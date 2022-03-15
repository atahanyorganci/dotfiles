function check_update
    set -l token_prefix /tmp/fish-config-update-token
    set -l today (date -u "+%Y-%m-%d")
    set -l token "$token_prefix-$today"
    if test -f $token
        return 0
    end
    set -l curr (pwd)
    cd $__fish_config_dir
    git fetch && git status | grep "Your branch is behind" >/dev/null
    if test $status = 0
        echo "Your fish configuration is out of date. Please update it with 'git pull'."
    else
        for file in "$token_prefix"-*
            rm $file
        end
        touch $token
    end
    cd $curr
end
