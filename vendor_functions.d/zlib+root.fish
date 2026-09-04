function (rcvr --def zlib root)
    set -l paths (path filter -d {/run,}/media/$USER/mobilehome0/$USER/Documents/e $HOME/Documents/e)
    echo $paths[1]
end
