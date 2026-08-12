function dispatch --description 'Dispatch to function.<platform>, else function'
    set --local name $argv[1]
    set --local target "$name."(platform)

    if functions --query $target
        $target $argv[2..-1]
    else if functions --query $name
        $name $argv[2..-1]
    else
        false
    end
end
