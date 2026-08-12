function direnv --wraps direnv --description "direnv first use wrapper"
    set --local me (status current-function)
    __{$me}.load
    $me $argv
end

# cd trigger
function __direnv.on-cd --on-variable PWD --description "trigger __direnv.load when entering a managed directory"
    if test -f .envrc; or test -f .env;
       set --local parts (string split . (status current-function))
        $parts[1].load
        __direnv_export_eval
    end
end

# call (and load) once
function __direnv.load
    functions --erase __direnv.on-cd direnv (status current-function)
    type -q direnv; or fish_command_not_found direnv
    
    # define --global variables here
    # set --global --export

    # direnv preexec hook (for fish)
    command direnv hook fish | source

    # rewrap the direnv command to add additional flags
    # (generally optional)
    function direnv --wraps direnv --description "direnv wrapper"
        # argparse ...
        set --local cmd (status current-function)
        command $cmd $argv
        #             ^ initial flags
    end
end

function direnv.install
    if type -q brew
        brew install direnv
    else if type -q apt
        sudo apt update
        sudo apt upgrade -y
        sudo apt install -y direnv
    else if type -q dnf
        sudo dnf update
        sudo dnf upgrade -y
        sudo dnf install -y direnv
    else
        set --local parts (string split . (status current-function))
        printf '%s cannot install %s on %s\n'  (status current-function) parts[1] (platform) >&2
    end        
end