#!/bin/sh
# dwb: Control w
url="$(curl -s "http://waa.ai/api.php?url=$(echo $DWB_URI | perl -MURI::Escape -lne 'print uri_escape($_)')")"
echo "$url" | loliclip -c
