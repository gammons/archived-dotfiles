#!/usr/bin/env bash

uptime | grep -ohe 'load average[s:][: ].*' | sed 's/,//g' | awk '{print $3" "$4" "$5}'
