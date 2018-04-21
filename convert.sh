#!/bin/bash

k=0

if [[ ! -f splatter-tux/shutdown_5_0.png ]]
then
    cp -a splatter-tux.png splatter-tux/shutdown_5_0.png
fi

convert splatter-tux.png -alpha extract mask.png
for j in $(ls -A | grep "shutdown_" | sort -g)
do
    output=$(echo splatter-tux/$(echo shutdown_5_$(echo $j | cut -c10-)))
    if [[ ! -f $output ]]
    then
        convert mask.png $j -composite temp.png
        convert splatter-tux.png temp.png -alpha Off -compose CopyOpacity -composite $output
    fi
done
rm mask.png temp.png

for i in $(cat sizes)
do
    k=$(expr $k + 1)
    for j in $(ls -A splatter-tux/ | grep "splatter_5" | sort -g)
    do
        output=$(echo splatter-tux/$(echo splatter_$(echo $k)_$(echo $j | cut -c12-)))
        if [[ ! -f $output ]]
        then
            convert splatter-tux/$j -resize $i $output
        fi
    done
    for j in $(ls -A splatter-tux/ | grep "shutdown_5" | sort -g)
    do
        output=$(echo splatter-tux/$(echo shutdown_$(echo $k)_$(echo $j | cut -c12-)))
        if [[ ! -f $output ]]
        then
            convert splatter-tux/$j -resize $i $output
        fi
    done
done
