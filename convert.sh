#!/bin/bash

what=$(ls -A | grep -E ".xcf$" | cut -f2 -d "-" | cut -f1 -d ".")

k=0
for i in $(cat sizes)
do
    k=$(expr $k + 1)
    for j in $(ls -A splatter-$what/ | grep "background_5" | sort -g)
    do
        output=$(echo splatter-$what/$(echo background_$(echo $k).png))
        if [[ ! -f $output ]]
        then
            convert splatter-$what/$j -resize $i $output
        fi
    done
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
