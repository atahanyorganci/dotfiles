complete -c pandoc_remove -s h -l help --description "print help message"
complete -c pandoc_remove -s f -l force --description "force remove files"
complete -c pandoc_remove -s d -l dry-run --description "dry run"
complete -c pandoc_remove -f -a "(_pandoc_remove_offer)"
