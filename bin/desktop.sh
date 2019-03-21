# set dpi
xrandr --dpi 92

# copy over the right Xdefaults
rm ~/.Xdefaults
rm ~/.Xresources
ln -s ~/.Xdefaults-big-monitor ~/.Xdefaults
ln -s ~/.Xdefaults-big-monitor ~/.Xresources

# reload xsessionrc
~/.xsessionrc

xrandr --output DP2 --auto

# update keyboard configuration
setxkbmap -option ''
setxkbmap -option ctrl:swapcaps -option altwin:swap_alt_win

rm ~/.config/alacritty/alacritty.yml
ln -s ~/.config/alacritty/alacritty.yml.big-monitor ~/.config/alacritty/alacritty.yml

# start imwheel to make scrolling faster
imwheel
