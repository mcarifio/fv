# FUTURE mike@carif.io: add multilog (apt install daemontools)

function log --description 'log [--level=info|warning|error|debug] $argv ## default level info'
    # @usage: log --level=warning "ima warnin' you!"
    set --local _flag_level info
    argparse --stop-nonopt 'level=' -- $argv; or return

    # logger --stderr --priority=user.$prio $argv[1..]
    begin; printf '%s: ' $_flag_level; printf '%s ' $argv; echo; end >&2
end

# warn "ima warning you!"
function warn
    log --level=(status current-function) $argv
end

for l in info error debug trace
    functions --erase $l &> /dev/null
    functions --copy warn $l
end

function log.automapper
    f.symlink (abspath (status filename)) (status current-function) info warning error debug trace
end


