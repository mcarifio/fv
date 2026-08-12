# is emacs actually installed?
status is-interactive; or return 0
set --local cmd (path basename --no-extension (status basename)) 
command --quiet $cmd; or fish_command_not_found $cmd

# is an emacs service available to run in the background?
if status is-login && systemctl --user list-unit-files emacs.service --no-legend --no-pager &> /dev/null and not systemctl --user is-active emacs
    loginctl enable-linger $USER
    systemctl --user enable --now emacs
end

function emacs --wraps emacs
    # argparse ...
    set --local cmd (status current-function)
    command $cmd $argv &
    #           ^ initial flags
end
