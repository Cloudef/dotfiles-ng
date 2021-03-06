#!/bin/sh
# Handle prefixes
# -- Applies registry fixes automatically
#    from regs directory

DEFAULT_LC_ALL="$LC_ALL"
ROOTDIR="${XDG_DATA_HOME:-$HOME/.local/share}/wine"
MYDOCS="$ROOTDIR/mydocs"

setupenv()
{
   export LC_ALL="$DEFAULT_LC_ALL"
   [[ -f "$WINEPREFIX/LANG" ]] && {
      export LC_ALL="$(cat "$WINEPREFIX/LANG")"
   }
}

rmdevice()
{
   echo -e "\t- Removing dos device: $(basename "$p")"
   rm "$p"
}

manage_prefix()
{
   baseprefix="$(basename "$WINEPREFIX")"
   echo ":: Managing: $baseprefix"
   setupenv

   # Init && Update prefix
   wineboot -u 2> /dev/null

   # Apply winetricks
   for w in "$ROOTDIR/winetricks/"*; do
      [[ "$w" == *@* ]] && [[ "$w" != *@"$baseprefix" ]] && continue
      rw="$(echo "$w" | sed "s/@$baseprefix//")"
      echo -e "\t+ Winetricks: $(basename "$rw")"
      winetricks "$(basename "$rw")" 2> /dev/null
   done

   # Apply registry fixes
   for r in "$ROOTDIR/regs/"*; do
      [[ "$r" == *@* ]] && [[ "$r" != *@"$baseprefix".reg ]] && continue
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

   # Create /mnt/storage symlink to D:
   echo -e "\t+ Symlinking D: to /mnt/storage"
   [[ -L "$WINEPREFIX/dosdevices/d:" ]] && rm "$WINEPREFIX/dosdevices/d:"
   ln -s "/mnt/storage" "$WINEPREFIX/dosdevices/d:"

   # Create /mnt/東方 symlink to E:
   echo -e "\t+ Symlinking E: to /mnt/東方"
   [[ -L "$WINEPREFIX/dosdevices/e:" ]] && rm "$WINEPREFIX/dosdevices/e:"
   ln -s "/mnt/東方" "$WINEPREFIX/dosdevices/e:"

   # Copy fonts to prefix
   for f in "$ROOTDIR/fonts/"*; do
      echo -e "\t+ Copying font: $(basename "$f")"
      cp "$f" "$WINEPREFIX/drive_c/windows/Fonts/"
   done

   # Remove symlinks from user directory
   for f in "$WINEPREFIX/drive_c/users/$(whoami)/"*; do
      [[ -L "$f" ]] && [[ -d "$f" ]] && {
         echo -e "\t+ Removing symlink $(basename "$f")"
         rm "$f"; mkdir "$f";
      }
   done

   # Symlink mydocs
   [[ -d "$WINEPREFIX/drive_c/users/$(whoami)/My Documents" ]] && {
        echo -e "\t+ Symlinking \"My Documents\" to \"$MYDOCS\""
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
   setupenv
   exec "$@"
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
