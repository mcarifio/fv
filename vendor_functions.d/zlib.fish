function zlib
    send (status current-function) $argv
end

function _zlib+root
    for d in  {/run,}/media/$USER/mobilehome0/$USER/Documents/e $HOME/Documents/e
        test -d $d; or continue
        echo $d; return 0
    end
end

function _zlib+category
    path bn $argv[1] 2
end

function _zlib.category2fqpn
    set --local category $argv[1]
    test -n $category; or ret "category '$category' missing?"
    set --local root (value $argv[2] $(zlib root))
    find $root \(-type d -o -type l -xtype d\) -name $category
end

function _zlib+format
    path bn 2
end

function _zlib+target -d 'zlib target $src [$dest]'
    set --local src $argv[1]
    test -n $src; or ret "$(status current-function): src needed"
    test -f $src; or ret "$(status current-function): src '$src' missing?"
    set --local dest (value $argv[2] (items=(find (zlib root) -name (zlib category $src) -type d) echo $items[1]))
    test -d $dest; or ret "$(status current-function): dest '$dest' missing?"
end