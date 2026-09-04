function sendr:sig -a sendr
    for f in (functions -n | string match -r "^$sendr\+[^:]+:sig\$"); $f; end
end