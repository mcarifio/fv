function path+abspath
    [ -n "$argv[1]" ]; and set -l pn $argv[1]; or return $(ret "bad")
    string match -qr '^/' $pn; and echo $pn; or path normalize "$PWD/$pn"
end