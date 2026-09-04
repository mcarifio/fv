function (rcvr --def zlib target) -a src
    [ -n "$src"]; or return (ret "src needed")
    set -l dest (value $argv[2] (items=(find (zlib root) -name (zlib category $src) -type d) echo $items[1]))
    [ -d "$dest"]; or return (ret "$(status function): dest '$dest' missing?")
end
