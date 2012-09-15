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
export WINEDIR="$XDG_DATA_HOME/wine"

alias dev="cd /mnt/storage/dev"
alias ogl="cd /mnt/storage/dev/projektit/glhck"
alias pkg="cd /arch/pkg"
alias pkgb="cd /arch/pkg/pkgbuild"
alias src="cd /arch/pkg/source"
alias manime="cd /mnt/anime"
alias mstorage="cd /mnt/storage"
alias winedir="cd $WINEDIR"
