# set dpi
xrandr --dpi 140

# copy over the right Xdefaults
rm ~/.Xdefaults
ln -s ~/.Xdefaults-laptop-monitor ~/.Xdefaults

# reload xsessionrc
~/.xsessionrc

# turn off the main monitor, turn on the laptop monitor
xrandr --output eDP1 --auto
xrandr --output DP1 --off

#update polybar
rm ~/.config/polybar/config
ln -s ~/.config/polybar/config-laptop-monitor ~/.config/polybar/config

# cp the correct i3 config for the monitor setup
rm ~/.config/i3/config
ln -s ~/.config/i3/config-laptop-monitor ~/.config/i3/config
i3-msg reload
i3-msg restart

# restart pulseaudio so it sees the HDMI audio out, and uses it
pulseaudio -k
pulseaudio -D
