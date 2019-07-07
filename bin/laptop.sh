# set dpi
xrandr --dpi 92

# copy over the right Xdefaults
rm ~/.Xdefaults
rm ~/.Xresources
ln -s ~/.Xdefaults-laptop-monitor ~/.Xresources
ln -s ~/.Xdefaults-laptop-monitor ~/.Xdefaults

# reload xsessionrc
~/.xsessionrc

# turn on the laptop monitor
xrandr --output eDP-1 --auto
xrandr --output eDP1 --auto

# turn off the main monitor
xrandr --output DP-2-2 --off
xrandr --output DP-1-2 --off

# update keyboard configuration
setxkbmap -option ''
setxkbmap -option ctrl:swapcaps -option altwin:hyper_win

rm ~/.config/alacritty/alacritty.yml
ln -s ~/.config/alacritty/alacritty.yml.laptop-monitor ~/.config/alacritty/alacritty.yml

# kill imwheel as it makes the trackpad jumpy
killall imwheel
