#!/bin/sh
run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

picom &
nitrogen --restore &
/usr/bin/lxpolkit
