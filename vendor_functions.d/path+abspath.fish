function (fname (status filename) pn:pathname!'test -r $pn')
    [ -n "$argv[1]" ]; and set -l pn $argv[1]; or return (log err "missing pathname")
    string match -qr '^/' $pn; and echo $pn; or builtin path normalize "$PWD/$pn"
end