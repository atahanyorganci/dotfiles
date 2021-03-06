function os --description "Get OS name (WSL/Darwin/Linux)"
    switch (uname -a)
        case "*WSL*"
            echo WSL
        case "*Darwin*"
            echo Darwin
        case "*Linux*"
            echo Linux
        case "*"
            return 1
    end
end
