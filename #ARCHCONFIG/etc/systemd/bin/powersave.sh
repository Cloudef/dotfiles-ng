#!/bin/sh
# Power saving options

# USB powersave
for i in /sys/bus/usb/devices/*/power; do
   [[ -f "$i/autosuspend" ]] || continue;
   echo 2 > "$i/autosuspend";
done &

# PCI, i2c powersave
for i in /sys/bus/{pci,i2c}/devices/*/power/control; do echo auto > $i; done &

# SATA powersave
for i in /sys/class/scsi_host/host*/link_power_management_policy; do echo min_power > $i; done &
echo min_power > /sys/class/scsi_host/host0/link_power_management_policy &

# Sound card powersave
echo 1 > /sys/module/snd_hda_intel/parameters/power_save &
echo Y > /sys/module/snd_hda_intel/parameters/power_save_controller &

# Disable WOL
which ethtool &> /dev/null && ethtool -s eth0 wol d &

exit 0
