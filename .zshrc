#
# .zshrc
#

# source system-wide configuration
source "/arch/shell/zshrc"
source "$HOME/.private"
source "$HOME/lib/anime/envanime"

export __GL_SYNC_TO_VBLANK=1
export __GL_SYNC_DISPLAY_DEVICE=DFP-0

alias ogl="cd /mnt/storage/dev/projektit/glhck"
alias pkg="cd /arch/pkg"
alias pkgb="cd /arch/pkg/pkgbuild"
alias src="cd /arch/pkg/source"
