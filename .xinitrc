xset r 66
xset r rate 250 55
xmodmap ~/.Xmodmap

# Set cursor
xsetroot -cursor_name left_ptr

feh --bg-fill /home/yoos/wallpapers/wp &
xmobar &
xcompmgr &
urxvtd &


exec xmonad
