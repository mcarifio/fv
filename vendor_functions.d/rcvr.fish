function (fname (status filename)) --no-scope-shadowing
    argparse def\& -- $argv
    set -l f (string join + $argv[1..2]); echo $f
    set -q _flag_def; or return 0
    set -l cmd $argv[1]
    set -l msg $argv[2]
    set -l argv $argv[3..]
    argparse -us -- $argv
    
    functions -q $cmd; or source $cmd.fish
    echo "function $f:sig; echo $f $argv_opts $argv[3..]; end" | builtin source
    # echo "function $f.call; argparse -us $(printf '%s\& ' (string sub -s 2 $argv_opts)) -- \$argv; set -s (
    # type $argv[1] $f.sig >&2
end
