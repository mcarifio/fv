# is emacsclient actually installed?
set -l cmd (path basename --no-extension (status basename)) 
type -q $cmd || fish_command_not_found $cmd

function emacsclient -w emacsclient -d "augments emacsclient with initial flags"
    # setting alternate-editor to null string defaults to `emacs --daemon` first and then connecting to that emacs server
    cmd=(status function) command $cmd --alternate-editor= --reuse-frame --no-wait --timeout=20 --quiet $argv
end

set -Ux VISUAL emacsclient
set -Ux EDITOR emacsclient
