#
# .zshrc
#

# export prezto directory
export ZDOTDIR="$HOME"

# source system-wide configuration
source "/arch/shell/zshrc"
source "$HOME/.private"
source "$HOME/lib/anime/envanime"

export __GL_SYNC_TO_VBLANK=1
export __GL_SYNC_DISPLAY_DEVICE=DFP-0
export __GL_THREADED_OPTIMIZATIONS=0

# wine related
export WINEDIR="${XDG_DATA_HOME-$HOME/.local/share}/wine"
export WINEPREFIX="$WINEDIR/prefixes/default"
alias winedir="cd $WINEDIR"

alias mplayer=mpv
alias homurapolkka='mpv -loop inf "/mnt/storage/videos/【MMD】Go home Homura, you are drunk【ハピトリ】HD Version!-kwiuX2OAvJg.mp4"'
alias sxivbooru="sxiv -R /mnt/storage/pictures/danbooru"

alias dev="cd /mnt/storage/dev"
alias ogl="cd /mnt/storage/dev/projektit/glhck"
alias pkg="cd /arch/pkg"
alias pkgb="cd /arch/pkg/pkgbuild"
alias src="cd /arch/pkg/source"
alias manime="cd /mnt/anime"
alias mstorage="cd /mnt/storage"
alias mstorage2="cd /mnt/storage2"
alias mth="cd /mnt/東方"
alias mcd="cd /mnt/東方/music"
alias eterm="vim ~/.config/termite/config"
