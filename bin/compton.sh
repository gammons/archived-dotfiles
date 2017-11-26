#!/bin/bash

killall -QUIT compton

sleep 0.5

compton -cCzG -t-3 -l-5 -r4 --config /dev/null --backend xrender --unredir-if-possible
#compton -b --config $HOME/dotfiles-local/compton.conf
