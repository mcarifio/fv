
function \? -a _true _colon _false
    # true|false ;? true : false
    [ $status -eq 0 ]; and echo $_true; or echo $_false
end