#!/bin/bash

# Define power options
options="Shutdown\nReboot\nSuspend\nHibernate\nCancel"
# Show the menu using your existing Rofi theme
chosen=$(echo -e "$options" | rofi -dmenu -p "Power")

case "$chosen" in
    Shutdown)
        systemctl poweroff
        ;;
    Reboot)
        systemctl reboot
        ;;
    Suspend)
        systemctl suspend
        ;;
    Hibernate)
        systemctl hibernate
        ;;
    Cancel)
        exit 0
        ;;
esac
