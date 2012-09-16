#!/bin/sh
# hdparam settings

# Make HDD's silent
hdparm -M254 /dev/disk/by-label/Anime   &> /dev/null
hdparm -M254 /dev/disk/by-label/Storage &> /dev/null
exit 0
