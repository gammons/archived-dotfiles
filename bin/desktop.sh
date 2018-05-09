# set dpi
xrandr --dpi 92

# copy over the right Xdefaults
rm ~/.Xdefaults
ln -s ~/.Xdefaults-big-monitor ~/.Xdefaults

# reload xsessionrc
~/.xsessionrc

xrandr --output DP1-2 --off
sleep  1
xrandr --output DP1-2 --auto

# update polybar
rm ~/.config/polybar/config
ln -s ~/.config/polybar/config-big-monitor ~/.config/polybar/config

# cp the correct i3 config for the monitor setup
rm ~/.config/i3/config
ln -s ~/.config/i3/config-big-monitor ~/.config/i3/config
i3-msg reload
i3-msg restart
