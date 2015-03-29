#!/bin/sh
### BEGIN INIT INFO
# Provides:          start_enc_disk
# Required-Start:    $local_fs $network
# Required-Stop:     $local_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: start LUKS encrypted disks
# Description:      LUKS encrypted disks 
### END INIT INFO

# 500GB partition with 300GB (same HD as / and swap)
# /sbin/cryptsetup luksOpen /dev/disk/by-uuid/ceed6aa5-03c1-40ee-b072-71939a46e468 ehd0 --key-file /media/usbkey/ehd0.key

# 320GB HD - SATA
# /sbin/cryptsetup luksOpen /dev/disk/by-uuid/04914ec6-6f90-44b9-901c-2415d1f44c8e ehd1 --key-file /media/usbkey/ehd0.key

# 320GB HD - IDE
# /sbin/cryptsetup luksOpen /dev/disk/by-uuid/569c9113-2769-495c-970a-8945c0a40960 ehd2 --key-file /media/usbkey/ehd0.key


exit 0
