function pkg+install -d 'pkg+install [--from $url] [--key $url] $pm://$pkg [$cmd]'
    argparse -sSu from= key= -- $argv

    set -l pm echo
    string match -rq '^(?<pm>[^:]+)://?<pkg>(.+)' $argv[1]; or return 1
    set -q pm; or return 1
    set -q pkg; or return 1
    set -l cmd (value $argv[2] $pkg)
    set -l action (string split + (status function))[2]

    $pm+$action $argv_opts $pkg $cmd
    command -q $cmd; or return 0
    version $cmd
end

function version -a cmd
    command $cmd --version &>/dev/null; and command $cmd --version; or command $command version
    return 0
end

function uv+install
    argparse -sSu -- $argv
    uv tool $argv_opts install $argv[1]; and fish_add_path fish_add_path (uv tool dir)/$argv[1]/bin
end

function apt+install
    sudo apt install -y $argv
end

function dnf+install
    sudo dnf install -y $argv
end

function brew+install
    brew install $argv
end

function eget+install
    eget $argv
end
