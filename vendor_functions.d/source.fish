# add a guard to sourcing a file file
function source -w source -d 'source $pathname[.$guard].fish'
     # builtin source $argv
     _source $argv
end

function _source -d '_source $pathname.$guard.fish'
    # argparse -sSu -- $argv # populates argv_opts
    # string length -q -- $argv[1]; or begin; echo "$(status function) expecting a pathname?"; return 1; end
    string length -q -- $argv[1]; or return 0
    set -l parts (string split . (path basename $argv[1]))
    set -l guard $parts[2]
    # set -s guard >&2
    # set -l fish_trace 1
    [ (count $parts) -le 2 ]; and _src $argv
    or status --is-login; and [ "$guard" = login ]; and _src $argv
    or status --is-interactive; and [ "$guard" = interactive ]; and _src $argv
    # login is an actual command
    or ! contains $guard -- login fish; and type -q $guard &>/dev/null; and $guard $argv[1] &>/dev/null; and _src $argv
end

function _src
    # argparse -sSu -- $argv # populates argv_opts
    string length -q -- $argv[1]; or begin; echo "$(status function) expecting a pathname?"; return 1; end
    builtin source $argv; and set -l _status $status
    set -q SOURCE_TRACE; and echo "$(status function) $(path resolve $argv[1]) => $_status" >&2
    return $_status
end
