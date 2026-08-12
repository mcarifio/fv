# is emacsclient actually installed?
set --local cmd (path basename --no-extension (status basename)) 
type --quiet $cmd || fish_command_not_found $cmd

function emacsclient --wrap emacsclient --description "augments emacsclient with initial flags"
    # setting alternate-editor to null string defaults to `emacs --daemon` first and then connecting to that emacs server
    set --local me (status current-function)
    command $me --alternate-editor= --reuse-frame --no-wait --timeout=20 --quiet $argv
end

ux VISUAL emacsclient
ux EDITOR emacsclient
