function (rcvr --def zlib category2fqpn) -a category
    [ -n "$category"]; or return (ret "category '$category' missing?")
    set -l root (value $argv[2] $(zlib root))
    find $root \(-type d -o -type l -xtype d\) -name $category
end
