function (rcvrf (status filename) db:pathname) --no-scope-shadowing
    set -f db (value "$argv[1]" "$(zlib root)/e.locate.db"); set -e argv[1]
    
    sudo updatedb --require-visibility=yes --add-prunenames='2sort 2sort-manually .attic' --output="$db" --database-root="$(path dirname $db)"
    sudo chown $USER:$USER "$db"
    echo "$db"
end