#!/bin/sh

sudo apt update && sudo apt upgrade -y

sudo apt install -y bspwm sxhkd xorg rofi polybar picom

mkdir -p ~/.config/bspwm ~/.config/sxhkd
