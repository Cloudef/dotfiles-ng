#!/bin/sh
# CPU freq options

# Change ondemand governor's up threshold
(sleep 10 && echo -n 25 > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold) &
exit 0
