function quick_proj --description "Quick project wizard"
    argparse -n quick_proj -X 0 "n/name=?" "d/description=?" -- $argv; or return 1
    if test -n "$_flag_name"
        set -f name $_flag_name
    else
        read -p "echo 'Project Name: '" -l name; or return 1
        set -f name $name
    end
    if test -n "$_flag_description"
        set -f description $_flag_description
    else
        read -p "echo 'Project Description: '" -l description; or return 1
        set -f description $description
    end
    set -l c (confirm "Do you want to add .gitignore?" --default=y); or return 1
    if test $c = y
        set -f gitignore (date -u "+/tmp/gitignore-%Y-%m-%d-%H-%M-%S")
        quick_ignore $gitignore >/dev/null; or return 1
        echo "Added .gitignore to $gitignore"
    end
    printf "Creating project %s at %s\n" $name $PWD
    mkdir $name && cd $name
    printf "# %s\n%s" $name >README.md
    if test -n $description
        printf "\n%s\n" $description >>README.md
    end
    mv $gitignore .gitignore
    git init >/dev/null && git add . && git commit -m "Initial commit" >/dev/null
end
