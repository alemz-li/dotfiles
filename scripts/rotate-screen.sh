#!/bin/bash

while true; do
    orientation=$(cat /sys/bus/iio/devices/iio:device*/in_incli_x_raw)

    if [ "$orientation" -lt 1000 ]; then
        xrandr --output eDP-1 --rotate normal
    else
        xrandr --output eDP-1 --rotate left
    fi

    sleep 1   # Adjust the sleep duration as needed
done

