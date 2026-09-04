function (rcvrf (status filename) msg:string\?) --no-scope-shadowing
    set -l parts (string split + (status function))
    log sink --$parts[2] $argv
end