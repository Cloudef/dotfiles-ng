#!/bin/sh
# Handle prefixes
# -- Applies registry fixes automatically
#    from regs directory

ROOTDIR="$XDG_DATA_HOME/wine"
MYDOCS="$ROOTDIR/mydocs"

rmdevice()
{
   echo -e "\t- Removing dos device: $(basename "$p")"
   rm "$p"
}

manage_prefix()
{
   echo ":: Managing: $(basename "$WINEPREFIX")"

   # Apply registry fixes
   for r in "$ROOTDIR/regs/"*; do
      echo -e "\t+ Applying: $(basename "$r")"
      regedit "$r" 2> /dev/null
   done

   # Remove paths to /
   # FIXME: needs more work
   # since wine looks up fonts, etc from Z:
   [[ 1 -eq 0 ]] && {
   for p in "$WINEPREFIX/dosdevices/"*; do
      [[ "$(readlink "$p")" == "/" ]] && rmdevice "$p"
   done
   }

   # Copy fonts to prefix
   for f in "$ROOTDIR/fonts/"*; do
      echo -e "\t+ Copying font: $(basename "$f")"
      cp "$f" "$WINEPREFIX/drive_c/windows/Fonts/"
   done

   # Symlink mydocs
   [[ -d "$WINEPREFIX/drive_c/users/$(whoami)/My Documents" ]] && {
        echo -e "\t+ Symlinking mydocs path"
        rm -r "$WINEPREFIX/drive_c/users/$(whoami)/My Documents"
        ln -s "$MYDOCS" "$WINEPREFIX/drive_c/users/$(whoami)/My Documents"
   }

   # End
   echo ""
}

call_if_exists()
{
   [[ -d "$WINEPREFIX" ]] || {
      echo "No such prefix: $(basename "$WINEPREFIX")"
      return
   }

   # run
   $@
}

main()
{
   [[ -n "$1" ]] && {
      local prefix="$1"
      shift 1
      [[ -n "$@" ]] && {
         WINEPREFIX="$ROOTDIR/prefixes/$prefix" \
            call_if_exists "$@"
         return
      } || {
         echo "Did not provide command for prefix"
      }
      return
   }

   # Manage each prefix
   for p in "$ROOTDIR/prefixes/"*; do
      WINEPREFIX="$p" manage_prefix
   done
}
main "$@"
