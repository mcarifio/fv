function rcvrf -a pathname --no-scope-shadowing
    # function (rcvrf (status filename) --one --two --three first second rest) -a first second third; ...
    set -l fname (path basename --no-extension $pathname); echo $fname
    echo $fname | read -d+ cmd msg
    set -e argv[1]
    argparse -us -- $argv
    
    functions -q $cmd; or source $cmd.fish
    echo "function $fname:sig; echo $fname $argv_opts $argv; end" | builtin source
    # echo "function $fname.call; argparse -us $(printf '%s\& ' (string sub -s 2 $argv_opts)) -- \$argv; set -s (
    # type $argv[1] $fname.sig >&2
end
