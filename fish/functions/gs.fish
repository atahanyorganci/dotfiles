function __gs
    git diff --color --stat=(math (tput cols) - 3) HEAD | sed '$d; s/^ //'
    git -c color.status=always status -sb
end

function gs --description "Pretty-print git status"
    __gs | gawk '
    $2 == "|" {
        nums[$1] = $3
        diff[$1] = $4;
    }
    $1 == "##" {
        print $0;
        stage = "status";
        max_file = 0;
        max_num = 0;
        for (i in diff) {
            max_file = max_file > length(i) ? max_file : length(i);
            max_num = max_num > length(nums[i]) ? max_num : length(nums[i]);
        }
    }
    stage == "status" && $1 != "##" {
        if ($2 in diff) {
            printf("%+10s %-*s | %+*s %s\n", $1, max_file, $2, max_num, nums[$2], diff[$2]);
        } else {
            print $0;
        }
    }
'
end
