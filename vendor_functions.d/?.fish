function \? -a _true _colon _false
    # true|false ;? true : false
    if [ $status -eq 0 ]
        echo $_true
    else
        [ $_colon = : ]; and echo $_false; or echo $_colon
    end
end