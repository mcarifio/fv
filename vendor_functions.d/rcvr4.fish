function (fname (status filename) cmd:function!'functions -q $cmd' msg:string) -a cmd msg --no-scope-shadowing
    set -l cmd (value $cmd msend)
    set -l msg (value $msg receivers)
    set -e argv[1..2]

    set -l fcmd $cmd+(string join + $msg)
    if functions -q $fcmd
        echo $fcmd
    else if builtin -q $cmd
        echo $cmd $msg
    else if command -q $cmd
        echo (command -s $cmd) $msg
    end
end