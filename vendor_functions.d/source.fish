# add a guard to sourcing a file file
function source -w source -d 'source $pathname[.$guard].fish'
     # builtin source $argv
     _source $argv
end

function _source -d '_source $pathname.$guard.fish'
    set -l flags trace; set -l passthru; set -l stay; argparse -sSu $flags -- $argv
    for a in $argv_opts; contains (string sub -s 3 -- $a) -- $flags; and set -a stay $a; or set -a passthru $a; end

    string length -q -- $argv[1]; or return 0
    set -l parts (string split . (path basename $argv[1]))
    set -l guard $parts[2]
    # set -s guard >&2
    # set -l fish_trace 1
    set -q _flag_trace; and set -lx SOURCE_TRACE 1
    [ (count $parts) -le 2 ]; and _src $argv
    or status --is-login; and [ "$guard" = login ]; and _src $passthru $argv
    or status --is-interactive; and [ "$guard" = interactive ]; and _src $passthru $argv
    # login is an actual command
    or ! contains $guard -- login fish; and type -q $guard &>/dev/null; and $guard $argv[1] &>/dev/null; and _src $passthru $argv
end

function _src
    # argparse -sSu -- $argv # populates argv_opts
    string length -q -- $argv[1]; or return 0
    builtin source $argv
    set -l _status $status
    set -q SOURCE_TRACE; and echo "$(status function) $(path resolve $argv[1]) => $_status" >&2
    return $_status
end
