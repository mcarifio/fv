function (rcvrf (status filename) --err||--warn||--info||--debug msg:string\?) --no-scope-shadowing
    set -f _status $status
    [ $_status != 0 ]; and set -f label err; or set -f label info
    argparse -us err\& warn\& info\& debug\& show\& -- $argv
    # set -s _flag_err _flag_warn _flag_info _flag_debug argv >&2

    if set -q _flag_err
        set -f label err
        [ $_status -eq 0 ]; and set -f _status 1
        set -q _flag_show; and set -s _flag_err label _status >&2
    else if set -q _flag_warn
        set -f label warn
        set -f _status 0
        set -q _flag_show; and set -s _flag_warn label _status >&2
    else if set -q _flag_info
        set -f label info
        set -f _status 0
        set -q _flag_show; and set -s _flag_info label _status >&2
    else if set -q _flag_debug
        set -f label debug
        set -f _status 0
        set -q _flag_show; and set -s _flag_debug label _status >&2
    end

    printf '%s: %s (status: %d)\n' (string upper $label) $argv[1] $_status >&2
    return $_status
end
