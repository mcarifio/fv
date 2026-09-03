function send
    # send --show --select=n $cmd $subcmd $args[3..]

    # FUTURE carif: send --select=3 $receiver --option0 $subcmd --option1 $subsubcmd $rest 
    argparse -us show\& select=\& -- $argv
    set -l _flag_select (value $_flag_select 2)
    set -l argv_opts0 $argv_opts
    
    # Dispatch to $cmd $subcmd [$subsubcmd], default `send+receivers()`.
    set -l cmd (value $argv[1] (status function))
    set -l subcmd (value $argv[2] receivers)
    # freceiver is the (candidate) function name for a function receiver.
    # Only dispatch to it if it's defined.
    set -l freceiver $cmd+(string join + $argv[2..$_flag_select])

    set -q _flag_show; and set -s _flag_select argv_opts0 cmd subcmd freceiver argv >&2
    if [ $subcmd = receivers ]
        send+receivers $cmd # => 1 if no receivers
    else if functions -q $freceiver
        $freceiver $argv_opts0 $argv[(math 1 + $_flag_select)..]
    else if builtin -q $cmd
        builtin $cmd $argv_opts0 $subcmd $argv[3..]
    else if command -q $cmd
        command $cmd $argv_opts0 $subcmd $argv[3..]
    else
        echo "$(status function): cannot $(status function) $cmd $subcmd $argv[3..]" >&2
        return 1
    end
end
