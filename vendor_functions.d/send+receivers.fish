function send+receivers
    argparse -us show\& trace\& -- $argv
    [ -n "$argv[1]" ]; and set -l re "^$argv[1]\+.*\$"; or set -l re '^[^+]+\+.*$';

    set -q _flag_show; and set -s re argv >&2
    set -q _flag_trace; and set -l fish_trace 1
    
    functions -q $argv[1]; and echo "function $argv[1]"
    printf 'receiver %s\n' (string match -r $re (functions -na))
    builtin -q $argv[1]; and echo "builtin $argv[1]"
    command -q $argv[1]; and echo "command $(command -sa $argv[1])"    
end