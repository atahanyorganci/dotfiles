function quick_ignore --description 'Choose and copy .gitignore from github/gitignore'
    argparse -n quick_ignore i/init u/update l/list -- $argv

    # github/gitignore should be locally available
    set -l data_dir $HOME/.local/share
    set -l repo $data_dir/gitignore/

    # Initialize `quick_ignore` by cloning github/gitignore to $HOME/.local/share/gitignore
    if test -n "$_flag_init"
        printf "Downloading github/gitignore to %s..." $repo
        mkdir -p $repo && git clone "https://github.com/github/gitignore" $repo >/dev/null 2>&1
        if test $status -eq 0
            printf " DONE!\n"
            return
        else
            printf " FAILED!\n"
            echo "run quick_ignore --init to try again"
            return 1
        end
    end

    # If $HOME/.local/share/gitignore isn't a directory, exit with error
    if test ! -d $repo
        echo "github/gitignore not found in $repo"
        echo "run quick_ignore --init to download it"
        return 1
    end

    # Update `quick_ignore` by pulling latest changes from github/gitignore
    if test -n "$_flag_update"
        printf "Updating github/gitignore in %s..." $repo
        set -l last $PWD
        cd $repo && git pull >/dev/null 2>&1
        set -l pull $status
        cd $last
        if test $pull -eq 0
            printf " DONE!\n"
            return
        else
            printf " FAILED!\n"
            echo "run quick_ignore --update to try again"
            return 1
        end
    end

    set -l list (ll $HOME/.local/share/gitignore/*.gitignore | awk '{ n = split($7, a, "/"); print a[n]; }')
    if test -n "$_flag_list"
        echo "Available gitignore files:"
        printf "%s\n" $list
    else
        if test (count $argv) != 1
            echo "Usage: quick_ignore [destination]"
            return 1
        end
        set -l dest $argv[1]
        set -l ignore (printf "%s\n" $list | fzf)
        echo "Copying '$ignore'"
        if test -z "$ignore"
            return 1
        else
            cp $repo/$ignore $dest
        end
    end
end
