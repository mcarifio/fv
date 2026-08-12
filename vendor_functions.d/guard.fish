function guard -d 'guard $predicate $argv # true iff is-interactive and $predicate is true'
    # guard $predicate $argv[2..]
    # example usage: guard command mise; or return 0 # $predicate is `command`
    status is-interactive; and _send (status current-function) $argv[1] $argv[2..]
end

function _guard+command
    command --query $argv[1]
end

