function (fname (status filename) --stderr rest:string\* ) --no-scope-shadowing
    set -f args $argv; argparse -us stderr\& -- $argv; set -f argv_opts0 $argv_opts
    echo (status function) $argv_opts0 $argv
end