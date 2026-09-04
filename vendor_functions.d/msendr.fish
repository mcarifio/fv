function (fname (status filename) pn:pathname) -a pn --no-scope-shadowing
    set -f parts (string split + (builtin path basename --no-extension $pn))
    echo $parts[1]
end