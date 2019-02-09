# set dpi
xrandr --dpi 92

# copy over the right Xdefaults
rm ~/.Xdefaults
ln -s ~/.Xdefaults-big-monitor ~/.Xdefaults

# reload xsessionrc
~/.xsessionrc

xrandr --output eDP-1 --off
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
rm ~/.Xmodmap
ln -s ~/.Xmodmap-big-monitor ~/.Xmodmap
xmodmap ~/.Xmodmap

rm ~/.config/alacritty/alacritty.yml
ln -s ~/.config/alacritty/alacritty.yml.big-monitor ~/.config/alacritty/alacritty.yml
