send_backlight_notification() {
  brightness=$(light)
  dunstify -a "Backlight" -u low -r 9994 -h int:value:"$brightness" -i "brightness" "Brightness" "Currently at $brightness%" -t 1000
}


backlight() {
  currentbrightness=$(light)
  let "brightnessMod = $currentbrightness / 20"
  case $1 in
    up)
      sudo light -A $brightnessMod
      send_backlight_notification "$1"
      ;;
    down)
      sudo light -U $brightnessMod
      send_backlight_notification "$1"
      ;;
  esac
}
