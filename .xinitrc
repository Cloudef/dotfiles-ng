#!/bin/sh
export _XINIT_WM="${@-"monsterwm"}"
_MONITOR_WIDTH=1440
_STATUS_HEIGHT=18
_STATUS_FONT="terminus"

# autostart
autostart() {
   # clipboard dmenu daemon
   clipbored
   # redshift for my eyes
   redshift -l 62:22 &> /dev/null &
   # start irc, torrent
   irc; torrent
}

# kill leftovers
autokill() {
   # kill clipboard dmenu daemon
   clipbored -k
   # kill redshift
   killall redshift
}

# special route for monsterwm
monsterwm_init() {
   local ff="/tmp/monsterwm.fifo"
   local pagerw=980
   local statusw=$((_MONITOR_WIDTH-pagerw))
   monsterpager "$ff" 1 | \
      dzen2 -h $_STATUS_HEIGHT -y 0 -w $pagerw -ta l -fn $_STATUS_FONT -e -p &
   monsterstatus | \
      dzen2 -h $_STATUS_HEIGHT -y 0 -x $pagerw -w $statusw -ta r -fn $_STATUS_FONT -e -p &

   while [[ ! -p "$ff" ]]; do sleep 1; done; sleep 2
   exec monsterwm | tee -a "$ff" &> /dev/null
   [[ -p "$ff" ]] && rm "$ff"
}

#
# dirty bits below
#

if [ -d /etc/X11/xinit/xinitrc.d ]; then
   for f in /etc/X11/xinit/xinitrc.d/*; do
      [ -x "$f" ] && . "$f"
   done
   unset f
fi

# UIM
export GTK_IM_MODULE='uim'
export XMODIFIERS=@im='uim'
export QT_IM_MODULE='uim'
uim-xim &> /dev/null &

xset s off
xset -dpms
setxkbmap fi
xrdb -load $HOME/.Xresources
xsetroot -cursor_name left_ptr
setxkbmap -option terminate:ctrl_alt_bksp

(sleep 2 && autostart) &
[[ "$_XINIT_WM" == "monsterwm" ]] && monsterwm_init
[[ "$_XINIT_WM" != "monsterwm" ]] && exec $_XINIT_WM &> /dev/null
autokill; sleep 1
