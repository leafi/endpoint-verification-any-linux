#!/bin/sh
set -eo pipefail
echo 'Checking for programs needed for unpack & installation'

# script needs this for unpacking/installing
which ar >/dev/null
which cksum >/dev/null
which cp >/dev/null
which curl >/dev/null
which grep >/dev/null
which rm >/dev/null
which sed >/dev/null
which tar >/dev/null
which install >/dev/null

# used by OS_VERSION patch to device_state.sh
ls /usr/bin/uname >/dev/null
ls /usr/bin/sed >/dev/null

echo 'Checking for stuff needed by Google scripts'

# /opt/google/endpoint-verification/bin/device_state.sh
ls /bin/echo >/dev/null
ls /bin/grep >/dev/null
ls /usr/bin/cut >/dev/null
ls /bin/cat >/dev/null
ls /bin/mountpoint >/dev/null
ls /bin/lsblk >/dev/null
ls /bin/udevadm >/dev/null
ls /usr/bin/awk >/dev/null
ls /usr/bin/tr >/dev/null
ls /usr/bin/printf >/dev/null
ls /proc/cmdline >/dev/null
ls /proc/mounts >/dev/null
# gsettings OR dconf
ls /usr/bin/gsettings >/dev/null || ls /usr/bin/dconf >/dev/null
ls /sys/class/dmi/id/product_serial >/dev/null
ls /sys/class/dmi/id/product_name >/dev/null
ls /bin/hostname >/dev/null
ls /sys/class/net/*/address >/dev/null
echo 'Checking for /etc/os-release; this is part of the LSB spec, not always shipped, but usually available via some package'
ls /etc/os-release >/dev/null

