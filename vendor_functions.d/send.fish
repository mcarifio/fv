function _send
    # send $cmd $subcmd $args[3..]
    set --local cmd (value $argv[1] (status current-function))
    set --local subcmd (value $argv[2] receivers)
    set --local receiver _$cmd+$subcmd
    if functions --query $receiver
        $receiver $argv[3..]
    else if builtin --query $cmd
        builtin $cmd $subcmd $argv[3..]
    else if command --query $cmd
        command $cmd $subcmd $argv[3..]
    else
        echo "$(status current-function): cannot $(status current-function) $cmd $subcmd $argv[3..]" >&2
        return 1
    end
end

function _send+receivers
    set --local receiver (value $argv[1] '^_[^\+]+')
    string match --regex $receiver (function --names --all)
end