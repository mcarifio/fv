function rcvr4 -a cmd msg
    set -l cmd (value $cmd send)
    set -l msg $argv[2..]

    set -l fcmd $cmd+(string join + $msg)
    if functions -q $fcmd
        echo $fcmd
    else if builtin -q $cmd
        echo $cmd $msg
    else if command -q $cmd
        echo (command -s $cmd) $msg
    end
end