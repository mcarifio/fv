# note:
# * all fish functions have global scope regardless of where they're defined
# * fish has no literal for a function
function fp
    _send (status current-function) $argv[1] $argv[2..]
end

function _fp+map -a cmd --description "apply $cmd, a command of 1 arg, to $argv[2..]"
    # usage: map echo (seq 0 3) |> 0\n\1\n\2\n\3\n
    # usage: map echo -n -- (seq 0 3) |> 0123\n
    # idiom:
    #     function math.pos? -a n; test $n -gt 0; end
    #     map math.pos? (seq 1 5)
    test $cmd = (status current-function); or ret "$(status current-function): '$cmd' will recurse infinitely"
    callable? $cmd; or ret "$(status current-function): '$cmd' not callable"
    set --function argv $argv[2..]
    set --function last (dashdash $argv)
    # set --show last flags argv >&2 # debug
    if test $last -gt 0
        # set --local fish_trace 1 # debug
        set flags $argv[1..$last]
        set argv $argv[$(math $last + 1)..]
    end
    # set --show last flags argv >&2 # debug

    # returns the status of the last command run; short-circuits on the first false
    # set --local fish_trace 1 # debug
    # run $cmd for each argument, perhaps with flags (if the command can take flags)
    for v in $argv; $cmd $flags $v; or return; end
end

