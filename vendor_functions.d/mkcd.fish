function mkcd -a folder --description "mkcd $folder ## cd to $folder, making it first if needed"
    test -d $folder; or mkdir -p $folder $argv[2..] 2>/dev/null; or ret "$(status current-function): mkdir $folder failed?"
    cd $folder
end