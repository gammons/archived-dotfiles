#!/bin/bash

killall -QUIT compton

sleep 0.5

compton -b --config $HOME/dotfiles-local/compton.conf
