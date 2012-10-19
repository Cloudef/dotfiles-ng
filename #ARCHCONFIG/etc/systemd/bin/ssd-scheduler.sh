#!/bin/sh
# Set correct scheduler for SSD disks

declare -ar SSDS=(
   'ata-OCZ-AGILITY3_OCZ-PEOA50X8TS772L78'
)

for SSD in "${SSDS[@]}"; do
   BY_ID=/dev/disk/by-id/$SSD
   if [[ -e "$BY_ID" ]]; then
      DEV_NAME=`ls -l $BY_ID | awk '{ print $NF }' | sed -e 's/[/\.]//g'`
      SCHED=/sys/block/$DEV_NAME/queue/scheduler

      if [[ -w $SCHED ]]; then
         echo cfq > $SCHED
      fi
   fi
done

exit 0
