xset r 66
xset r rate 200 65
xmodmap ~/.Xmodmap

# Set cursor
xsetroot -cursor_name left_ptr
setxkbmap us -variant colemak

#xrandr --output LVDS1 --off &&
#xrandr --output DVI1 --mode 1600x1200 &&

#feh --bg-fill /home/yoos/wallpapers/wp &
#feh --bg-fill "$(find ~/wallpapers/|shuf -n1)" &   # Set random wallpaper
feh --bg-fill ~/wallpapers/apod121222_PIA14934_saturn.jpg &   # Set wallpaper
xmobar &
xcompmgr &
urxvtd &
synergyc syoo-z2 &


exec xmonad
