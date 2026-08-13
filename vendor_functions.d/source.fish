# add a guard to sourcing a file
# builtin source source.fish ## during debugging
 
function source -w source -d 'source $pathname[.$guard].fish'
     _source $argv
end

function _source -d '_source $pathname.$guard.fish'
    set -l flags trace; set -l goes; set -l stays; argparse -sSu $flags -- $argv
    for a in $argv_opts; contains (string sub -s 3 -- $a) -- $flags; and set -a stays $a; or set -a goes $a; end
    set -q _flag_trace; and set -lx SOURCE_TRACE 1

    set -l parts (string split . (path basename $argv[1]))
    # set -s argv_opts stays goes argv pn guard >&2
    # set -l fish_trace 1
    if [ (count $parts) -le 2 ]
        _src $goes $argv
    else
        set -l guard guard.$parts[-2]
        type -q $guard &>/dev/null
        and $guard $argv[1] &>/dev/null
        and _src $goes $argv
    end
end

function guard.interactive; status --is-interactive; end
function guard.login; status --is-interactive; end
function guard.skip; false; end
function guard.true; true; end
function guard.false; false; end

function _src
    builtin source $argv
    set -l _status $status
    set -q SOURCE_TRACE; and echo "source $argv => $_status" >&2
    return $_status
end
