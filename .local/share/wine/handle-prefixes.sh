#!/bin/sh
# Handle prefixes
# -- Applies registry fixes automatically
#    from regs directory

MYDOCS="$PWD/mydocs"

rmdevice()
{
   echo -e "\t- Removing dos device: $(basename "$p")"
   rm "$p"
}

manage_prefix()
{
   echo ":: Managing: $(basename $WINEPREFIX)"

   # Apply registry fixes
   for r in $PWD/regs/*; do
      echo -e "\t+ Applying: $(basename "$r")"
      regedit "$r" 2> /dev/null
   done

   # Remove paths to /
   for p in $WINEPREFIX/dosdevices/*; do
      [[ "$(readlink "$p")" == "/" ]] && rmdevice "$p"
   done

   # Copy fonts to prefix
   for f in fonts/*; do
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
   [[ -d "$PWD/prefixes/$1" ]] || {
      echo "No such prefix: $1"
      return
   }

   which $2 &> /dev/null || {
      echo "No such command: $2"
      return
   }

   WINEPREFIX="$PWD/prefixes/$1" $2 > /dev/null
}

main()
{
   [[ -n "$1" ]] && {
      local prefix="$1"
      shift 1
      [[ -n "$@" ]] && {
         call_if_exists "$prefix" "$@"
      } || {
         echo "Did not provide command for prefix"
      }
      return
   }

   # Manage each prefix
   for p in $PWD/prefixes/*; do
      WINEPREFIX="$p" manage_prefix
   done
}
main "$@"
