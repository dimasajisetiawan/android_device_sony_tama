#!/system/bin/sh
#
# Copyright (c) 2019-2020 Martin Dünkelmann
# All rights reserved.
#
# We use this shell script because the script will follow symlinks and
# different trees will use different binaries to supply the setenforce
# tool. Before M we use toolbox, M and beyond will use toybox. The init
# binary and init.rc will not follow symlinks.

touch_id=`cat /sys/devices/dsi_panel_driver/panel_id`

mkdir -p /tmp/vendor

#XZ2 "3" XZ2C "4" Clearpad
if [ "$touch_id" = "3" ] || [ "$touch_id" = "4" ]; then
    insmod /sbin/clearpad_rmi_dev.ko
    insmod /sbin/clearpad_core.ko
    insmod /sbin/clearpad_i2c.ko

    if ! [ -e /sys/bus/platform/devices/clearpad-rmi-dev ]; then
        mount -o ro /dev/block/by-name/vendor /tmp/vendor && {
            cp -p /tmp/vendor/lib/modules/clearpad_rmi_dev.ko /sbin
            cp -p /tmp/vendor/lib/modules/clearpad_core.ko /sbin
            cp -p /tmp/vendor/lib/modules/clearpad_i2c.ko /sbin
            umount /tmp/vendor

            insmod /sbin/clearpad_rmi_dev.ko
            insmod /sbin/clearpad_core.ko
            insmod /sbin/clearpad_i2c.ko
        }
    fi

    echo 1 > /sys/devices/virtual/input/clearpad/post_probe_start
fi

#XZ2 "7" XZ2C "8" TCM
if [ "$touch_id" = "7" ] || [ "$touch_id" = "8" ]; then
    insmod /sbin/synaptics_tcm_i2c.ko
    insmod /sbin/synaptics_tcm_core.ko
    insmod /sbin/synaptics_tcm_touch.ko
    insmod /sbin/synaptics_tcm_device.ko
    insmod /sbin/synaptics_tcm_testing.ko
    insmod /sbin/synaptics_tcm_reflash.ko
    insmod /sbin/synaptics_tcm_recovery.ko
    insmod /sbin/synaptics_tcm_diagnostics.ko

    if ! [ -e /sys/bus/i2c/drivers/synaptics_tcm_i2c ]; then
        mount -o ro /dev/block/by-name/vendor /tmp/vendor && {
            cp -p /tmp/vendor/lib/modules/synaptics_tcm_i2c.ko /sbin
            cp -p /tmp/vendor/lib/modules/synaptics_tcm_core.ko /sbin
            cp -p /tmp/vendor/lib/modules/synaptics_tcm_touch.ko /sbin
            cp -p /tmp/vendor/lib/modules/synaptics_tcm_device.ko /sbin
            cp -p /tmp/vendor/lib/modules/synaptics_tcm_testing.ko /sbin
            cp -p /tmp/vendor/lib/modules/synaptics_tcm_reflash.ko /sbin
            cp -p /tmp/vendor/lib/modules/synaptics_tcm_recovery.ko /sbin
            cp -p /tmp/vendor/lib/modules/synaptics_tcm_diagnostics.ko /sbin
            umount /tmp/vendor

            insmod /sbin/synaptics_tcm_i2c.ko
            insmod /sbin/synaptics_tcm_core.ko
            insmod /sbin/synaptics_tcm_touch.ko
            insmod /sbin/synaptics_tcm_device.ko
            insmod /sbin/synaptics_tcm_testing.ko
            insmod /sbin/synaptics_tcm_reflash.ko
            insmod /sbin/synaptics_tcm_recovery.ko
            insmod /sbin/synaptics_tcm_diagnostics.ko
        }
    fi
fi

#XZ2P SSW
if [ "$touch_id" = "9" ]; then
    insmod /sbin/ssw49501.ko
    insmod /sbin/ssw_mon.ko

    if ! [ -e /sys/bus/i2c/drivers/siw_touch ]; then
        mount -o ro /dev/block/by-name/vendor /tmp/vendor && {
            cp -p /tmp/vendor/lib/modules/ssw49501.ko /sbin
            cp -p /tmp/vendor/lib/modules/ssw_mon.ko /sbin
            umount /tmp/vendor

            insmod /sbin/ssw49501.ko
            insmod /sbin/ssw_mon.ko
        }
    fi

    echo 1 > /sys/devices/virtual/input/siw_touch_input/init_late_session
fi

#XZ3 ATMEL
if [ "$touch_id" = "5" ]; then
    insmod /sbin/atmel_mxt640u.ko

    if ! [ -e /sys/bus/i2c/drivers/touch_atmel ]; then
        mount -o ro /dev/block/by-name/vendor /tmp/vendor && {
            cp -p /tmp/vendor/lib/modules/atmel_mxt640u.ko /sbin
            umount /tmp/vendor

            insmod /sbin/atmel_mxt640u.ko
        }
    fi

    echo 1 > /sys/devices/virtual/input/lge_touch/charge_out
fi
