#!/bin/sh
export _XINIT_WM="${@-"monsterwm"}"

# autostart
autostart() {
   # wait for wm
   while ! killall -0 $_XINIT_WM; do sleep 1; done
   # start devmon
   (devmon --unmount-all; devmon) &
   # nitrogen
   nitrogen --restore
   # start stalonetray daemon
   stalonetrayd
   # redshift for my eyes
   redshift -l 62:22 -m vidmode &> /dev/null &
   # start irc, rss, torrent
   irc; rss; torrent;
   # loliclip clipboard manager
   loliclip -d
}

# kill leftovers
autokill() {
   # kill redshift
   killall redshift
   # kill loliclip
   killall loliclip
   # kill stalonetray
   killall stalonetray
   # kill devmon
   devmon --unmount-all
   killall devmon
}

# monsterwm bar
monsterwm_bar() {
   local ff="/tmp/monsterwm.fifo"
   pgrep -x "^monsterstatus" > /dev/null || {
      monsterstatus "$ff" | bar &
   }
}

# special route for monsterwm
monsterwm_init() {
   local ff="/tmp/monsterwm.fifo"
   rm "$ff"; monsterwm_bar
   while [[ ! -p "$ff" ]]; do sleep 1; done; sleep 1
   exec monsterwm | tee -a "$ff" &> /dev/null
   [[ -p "$ff" ]] && rm "$ff"
}

# Check if wm is already running
pgrep -x "^$_XINIT_WM" > /dev/null && { monsterwm_bar; exit 0; }

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

xset +fp /usr/share/fonts/local
xset r rate 350 45
xset s off
xset -dpms
setxkbmap fi
xrdb -load $HOME/.Xresources
xsetroot -cursor_name left_ptr
setxkbmap -option terminate:ctrl_alt_bksp
nvidia-load-settings &> /dev/null

autostart &
[[ "$_XINIT_WM" == "monsterwm" ]] && monsterwm_init
[[ "$_XINIT_WM" != "monsterwm" ]] && exec $_XINIT_WM &> /dev/null
autokill; sleep 1
