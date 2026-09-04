function (fname (status filename) pn:string) --no-scope-shadowing
    [ -n "$argv[1]" ]; and set -l pn "$argv[1]"; or return $(log err "missing pn")
    set -l left (value $argv[2] 1)
    set -l right (value $argv[3] $left)
    set -l result (string split . (path basename $pn))
    string join . $result[$left..$right]
end
