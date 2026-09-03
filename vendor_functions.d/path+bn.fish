function path+bn
    [ -n "$argv[1]" ]; and set -l pathname $argv[1]; or return $(ret "missing pathname")
    set -l left (value $argv[2] 1)
    set -l right (value $argv[3] $left)
    set -l result (string split . (path basename $pathname))
    string join . $result[$left..$right]
end
