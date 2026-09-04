function (rcvrf (status filename) --db=db:pathname) --no-scope-shadowing
    argparse -us show\& db=\& a/author=\& c/category=\& -- $argv
    set -f db (value "$_flag_db_value" "$(zlib root)/e.locate.db")
    # locate --database="$db" --regex -- "-$author-[[:digit:]][[:digit:]][[:digit:]][[:digit:]]\.$category\."
    locate --database="$db" -- $argv
end
