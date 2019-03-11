# set dpi
xrandr --dpi 92

# copy over the right Xdefaults
rm ~/.Xdefaults
rm ~/.Xresources
ln -s ~/.Xdefaults-big-monitor ~/.Xdefaults
ln -s ~/.Xdefaults-big-monitor ~/.Xresources

# reload xsessionrc
~/.xsessionrc

xrandr --output eDP-1 --off
xrandr --output eDP1 --off
xrandr --output DP-2-2 --off
sleep  1
xrandr --output DP-2-2 --auto

# update polybar
rm ~/.config/polybar/config
ln -s ~/.config/polybar/config-big-monitor ~/.config/polybar/config

# cp the correct i3 config for the monitor setup
rm ~/.config/i3/config
ln -s ~/.config/i3/config-big-monitor ~/.config/i3/config
i3-msg reload
i3-msg restart

# update keyboard configuration
setxkbmap -option ''
setxkbmap -option ctrl:swapcaps -option altwin:swap_alt_win

rm ~/.config/alacritty/alacritty.yml
ln -s ~/.config/alacritty/alacritty.yml.big-monitor ~/.config/alacritty/alacritty.yml

# start imwheel to make scrolling faster
imwheel
