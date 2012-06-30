#!/bin/sh
# dwb: Control y
domain() {
   echo $@ | sed -e "s/[^/]*\/\/\([^@]*@\)\?\([^:/]*\).*/\2/"
}

main() {
   case "$(domain $DWB_URI)" in
      *youtube.com)
         mplayer -really-quiet -cache 300 "$(youtube-dl -f 18 -g "$DWB_URI")" &> /dev/null
      ;;
      *nicovideo.jp)
         nicoplay "$DWB_URI" &> /dev/null
      ;;
   esac
}

main
