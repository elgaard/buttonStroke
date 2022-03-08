#!/bin/bash
bindir=$HOME/src/garmin/bin

retest="fenix6 fenix6pro fenix6spro"
crit="instinct2 instinct2s "
glance="marqadventurer"
# instinct2s UPD: 163,156


for fn in $HOME/src/garmin/bin/*.prg; do
    echo $fn
    st=${fn%%.prg}
    dev=${st#$bindir/ButtonRate-}
    echo test device $dev
    $bindir/monkeydo $fn $dev&
    echo return for next
    read $x    
done
