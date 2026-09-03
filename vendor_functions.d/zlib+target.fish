function zlib+target
    set --local src $argv[1]
    test -n $src; or ret "$(status current-function): src needed"
    test -f $src; or ret "$(status current-function): src '$src' missing?"
    set --local dest (value $argv[2] (items=(find (zlib root) -name (zlib category $src) -type d) echo $items[1]))
    test -d $dest; or ret "$(status current-function): dest '$dest' missing?"
end
