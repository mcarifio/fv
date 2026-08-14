set -l cmd (path basename --no-extension (status filename))

if command -q $cmd
    function $cmd -w $cmd; fn=_(status function) $fn $argv; end
    function _$cmd -d "$cmd helper"
        # before
        cmd=(string sub -s 2 (status function)) command $cmd $argv
        set -l _status $status
        # after
        return $_status
    end
else
    echo "$cmd missing from PATH?" >&2
    function -e $cmd
    gzip --verbose (status filename)
end
