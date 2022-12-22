#!/bin/sh


#clock and date
while :; do
    [ "$is_time_sync" = "0" ] && {
        while :; do
            datesync1=$(date "+%M")
            sleep .05
            datesync2=$(date "+%M")
            [ ! "$datesync1" = "$datesync2" ] && {
                is_time_sync=1
                break
            }
        done
        continue
    }
    string=$(date "+%a %d %b  %l:%M %p")
    xsetroot -name "$string"
    sleep 60
done &
