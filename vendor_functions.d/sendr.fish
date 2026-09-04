function sendr -a pathname
    set -f parts (string split + (path basename --no-extension $pathname))
    echo $parts[1]
end