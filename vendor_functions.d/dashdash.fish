function dashdash
    for i in (seq 1 (count $argv)); test $argv[$i] = --; and echo $i; and return; end
    echo 0
end
