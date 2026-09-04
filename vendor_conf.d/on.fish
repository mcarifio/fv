status is-interactive; and command -q direnv &>/dev/null; or return 0

# hack: attach a variable change function to PWD to `direnv allow` iff:
# * direnv on PATH
# * $PWD/.envrc exists
function _on_cd --on-variable PWD -d "actions when entering a folder"
    test -f .envrc; and direnv allow 2>/dev/null
end
    