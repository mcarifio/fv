function rcvr --no-scope-shadowing
    argparse -us def\& -- $argv
    set -l f (string join + $argv[1..2]); echo $f
    set -q _flag_def; or return 0
    function $argv[1]; send (status function) $argv; end
    echo "function $f.sig; echo (status function) $argv_opts $argv[3..]; end" | builtin source
    # type $argv[1] $f.sig >&2
end
