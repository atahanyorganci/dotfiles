#!/usr/bin/env fish

set -l URL "https://raw.githubusercontent.com/dracula/kitty/master/dracula.conf"
set -l PROGRAM '
$1 != "#" && $0 != "" {
    colors[$1] = $2;
}
END {
    n = asorti(colors, sorted);
    len = -1;
    for (i = 1; i <= n; i++) {
        if (len < length(sorted[i])) {
            len = length(sorted[i]);
        }
    }
    for (i = 1; i <= n; i++) {
        key = sorted[i];
        value = colors[key];
        printf("%-*s %s\n", len, key, value);
    }
}'
set -l FILE "$HOME/.config/kitty/dracula.conf"
echo "# Dracula Theme" > $FILE
curl $URL | awk $PROGRAM >> $FILE
