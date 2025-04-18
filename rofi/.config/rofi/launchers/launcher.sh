#!/usr/bin/env bash
#  ┓ ┏┓┳┳┳┓┏┓┓┏┏┓┳┓
#  ┃ ┣┫┃┃┃┃┃ ┣┫┣ ┣┫
#  ┗┛┛┗┗┛┛┗┗┛┛┗┗┛┛┗
#                  


# Style-dir
style_dir="$HOME/.config/rofi/launchers/styles"

# Style-theme
style_theme='style-6'


# Run
pkill rofi || true && rofi  ${1:--show drun} -theme ${style_dir}/${style_theme}.rasi
