# set dpi
xrandr --dpi 92

# copy over the right Xdefaults
rm ~/.Xdefaults
ln -s ~/.Xdefaults-big-monitor ~/.Xdefaults

# reload xsessionrc
~/.xsessionrc

# turn off the macbook monitor
xrandr --output eDP1 --off
xrandr --output DP1 --auto --right-of eDP1

# update polybar
rm ~/.config/polybar/config
ln -s ~/.config/polybar/config-big-monitor ~/.config/polybar/config

# cp the correct i3 config for the monitor setup
rm ~/.config/i3/config
ln -s ~/.config/i3/config-big-monitor ~/.config/i3/config
i3-msg reload
i3-msg restart

# restart pulseaudio so it sees the HDMI audio out, and uses it
pulseaudio -k
pulseaudio -D
