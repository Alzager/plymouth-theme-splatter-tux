#!/bin/bash

what=$(ls -A | grep -E ".xcf$" | cut -f2 -d "-" | cut -f1 -d ".")

if [[ ! -f splatter-$what/shutdown_5_0.png ]]
then
    cp -a splatter-$what.png splatter-$what/shutdown_5_0.png
fi

convert splatter-$what.png -alpha extract mask.png
for j in $(ls -A | grep "shutdown_" | sort -g)
do
    output=$(echo splatter-$what/$(echo shutdown_5_$(echo $j | cut -c10-)))
    if [[ ! -f $output ]]
    then
        convert mask.png $j -composite temp.png
        convert splatter-$what.png temp.png -alpha Off -compose CopyOpacity -composite $output
    fi
done
rm mask.png temp.png

k=0
for i in $(cat sizes)
do
    k=$(expr $k + 1)
    for j in $(ls -A splatter-$what/ | grep "splatter_5" | sort -g)
    do
        output=$(echo splatter-$what/$(echo splatter_$(echo $k)_$(echo $j | cut -c12-)))
        if [[ ! -f $output ]]
        then
            convert splatter-$what/$j -resize $i $output
        fi
    done
    for j in $(ls -A splatter-$what/ | grep "shutdown_5" | sort -g)
    do
        output=$(echo splatter-$what/$(echo shutdown_$(echo $k)_$(echo $j | cut -c12-)))
        if [[ ! -f $output ]]
        then
            convert splatter-$what/$j -resize $i $output
        fi
    done
done
