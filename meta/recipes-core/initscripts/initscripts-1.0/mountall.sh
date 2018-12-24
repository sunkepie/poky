#!/bin/sh
### BEGIN INIT INFO
# Provides:          mountall
# Required-Start:    mountvirtfs
# Required-Stop: 
# Default-Start:     S
# Default-Stop:
# Short-Description: Mount all filesystems.
# Description:
### END INIT INFO

. /etc/default/rcS

#
# Mount local filesystems in /etc/fstab. For some reason, people
# might want to mount "proc" several times, and mount -v complains
# about this. So we mount "proc" filesystems without -v.
#
test "$VERBOSE" != no && echo "Mounting local filesystems..."
mount -at nonfs,nosmbfs,noncpfs 2>/dev/null

#
# We might have mounted something over /dev, see if /dev/initctl is there.
#
if test ! -p /dev/initctl
then
	rm -f /dev/initctl
	mknod -m 600 /dev/initctl p
fi
kill -USR1 1

#
# Execute swapon command again, in case we want to swap to
# a file on a now mounted filesystem.
#
swapon -a 2> /dev/null

ubiattach /dev/ubi_ctrl -m 5
ubiattach /dev/ubi_ctrl -m 6

mount -t ubifs ubi1_0 /rbctrl
mount -t ubifs ubi2_0 /update


if grep -qs '/rbctrl' /proc/mounts; then
    	echo "rbctrl mounted."
else 
	mount -t tmpfs tmpfs /rbctrl 
fi

if grep -qs '/update' /proc/mounts; then
        echo "update mounted."
else
        mount -t tmpfs tmpfs /update
fi


/usr/sbin/readhardware &




: exit 0

