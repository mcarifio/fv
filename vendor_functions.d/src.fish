# add a guard to sourcing a file
# builtin source source.fish ## during debugging
 
function (fname (status filename)) -w source -d 'src $pathname[.$guard].fish'
     _(status function) $argv
end

function _src -d '_source $pathname.$guard.fish'
    set -l flags trace; set -l goes; set -l stays; argparse -su $flags -- $argv
    for a in $argv_opts; contains (string sub -s 3 -- $a) -- $flags; and set -a stays $a; or set -a goes $a; end
    set -q _flag_trace; and set -lx SOURCE_TRACE 1

    set -l parts (string split . (path basename $argv[1]))
    # set -s argv_opts stays goes argv pn guard >&2
    # set -l fish_trace 1
    if [ (count $parts) -le 2 ]
        _(status function) $goes $argv
    else
        set -l guard guard.$parts[-2]
        type -q $guard &>/dev/null
        and $guard $argv[1] &>/dev/null
        and _(status function) $goes $argv
    end
end

function guard.interactive; status --is-interactive; end
function guard.login; status --is-interactive; end
function guard.skip; false; end
function guard.true; true; end
function guard.false; false; end

function __src
    builtin source $argv
    set -l _status $status
    set -q SOURCE_TRACE; and echo "source $argv => $_status" >&2
    return $_status
end
