set -l here (path resolve (status dirname))
source $here/included.fish
set -l src source
$src --trace $here/included.fish
$src $here/included.login.fish
$src $here/included.interactive.fish
$src $here/included.skip.fish
$src $here/included.true.fish
$src $here/included.false.fish
