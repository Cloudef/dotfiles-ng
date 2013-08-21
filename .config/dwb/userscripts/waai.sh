#!/bin/sh
# dwb: Control w
url="$(curl -s "http://api.waa.ai/?url=$(echo $DWB_URI | perl -MURI::Escape -lne 'print uri_escape($_)')")"
echo "$url" | loliclip -ci
