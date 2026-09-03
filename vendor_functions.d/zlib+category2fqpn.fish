function zlib+category2fqpn
    set --local category $argv[1]
    test -n $category; or ret "category '$category' missing?"
    set --local root (value $argv[2] $(zlib root))
    find $root \(-type d -o -type l -xtype d\) -name $category
end
