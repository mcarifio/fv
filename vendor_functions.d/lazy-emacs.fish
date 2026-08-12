function emacs --wraps emacs --description "emacs first use wrapper"
    set --local me (status current-function)
    __{$me}.load
    $me $argv
end

# call (and load) once
function __emacs.load
    functions --erase emacs (status current-function)
    type -q emacs; or fish_command_not_found emacs
    
    # run emacs daemon as a service
    if not systemctl --user is-active emacs
        loginctl enable-linger $USER
        systemctl --user enable --now emacs
    end

    # rewrap the emacs command to add additional flags
    # (generally optional)
    function emacs --wraps emacs --description "emacs wrapper"
        # argparse ...
        set --local cmd (status current-function)
        command $cmd $argv
        #           ^ initial flags
    end
end

function emacs.install
    if type -q brew
        brew upgrade
        brew install --cask emacs
    else if type -q apt
        sudo apt update
        sudo apt upgrade -y
        sudo apt install -y emacs
    else if type -q dnf
        sudo dnf update
        sudo dnf upgrade -y
        sudo dnf install -y emacs
    else
        set --local parts (string split . (status current-function))
        printf '%s cannot install %s on %s\n'  (status current-function) parts[1] (platform) >&2
        return 1
    end
    ux VISUAL emacsclient
    ux EDITOR emacsclient
end
