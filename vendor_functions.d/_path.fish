function path -w path
    _send (status current-function) $argv[1] $argv[2..]
end

function _path+bn
    set --local pathname $argv[1]
    test -n $pathname; or ret "pathname '$pathname' missing?"
    set --local left (value $argv[2] 1)
    set --local right (value $argv[3] $left)
    set --local parts (string split . (path basename $pathname))
    string join . $parts[$left..$right]
end

function _path+is-compressed
    set --local pathname $argv[1]
    test -n $pathname; or ret "pathname '$pathname' missing?"
    file -b $pathname | grep --quiet 'compressed data'
end

