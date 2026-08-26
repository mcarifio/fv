function value
    for a in $argv[..-2]
        if [ -n "$a" ]
            echo "$a"; return 0
        end
    end
    echo $argv[-1]
end