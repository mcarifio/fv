function sig
    set -l f (rcvr $argv[1] $argv[2]).sig
    functions -q $f; and $f
end