#!/system/bin/sh
# Do NOT assume where your module will be located.
# ALWAYS use $MODDIR if you need to know where this script
# and module is placed.
# This will make sure your module will still work
# if Magisk change its mount point in the future
MODDIR=${0%/*}
# This script will be executed in post-fs-data mode

#resetprop ro.boot.hwc GLOBAL
#resetprop ro.boot.hwcountry GLOBAL

BRAND=$(getprop ro.com.google.clientidbase)

maybe_set_prop() {
    local prop="$1"
    local contains="$2"
    local value="$3"

    if [[ "$(getprop "$prop")" == *"$contains"* ]]; then
        resetprop "$prop" "$value"
    fi
}

maybe_set_prop gsm.sim.operator.numeric "," "44011,44011"
maybe_set_prop gsm.sim.operator.iso-country "," "jp,jp"

# Delete region lock config
mount -o ro,bind $MODDIR/xml/regionlock_config.xml /mnt/vendor/my_bigball/etc/regionlock_config.xml
mount -o ro,bind $MODDIR/xml/regionlock_config.xml /mnt/vendor/my_product/etc/regionlock_config.xml
mount -o ro,bind $MODDIR/xml/regionlock_config.xml /mnt/vendor/my_region/etc/regionlock_config.xml

resetprop -n ro.oplus.radio.global_regionlock.enabled false
resetprop -n persist.sys.radio.global_regionlock.allcheck false
resetprop -n persist.sys.oplus.radio.globalregionlock 0,0
resetprop -n persist.sys.oplus.radio.haslimited false
resetprop -n ro.oplus.radio.checkservice false
resetprop -n persist.sys.oplus.bnoticetimes -200000
resetprop -n persist.sys.oplus.pnoticetimes -200000
resetprop -n gsm.sim.oplus.radio.fnoticetime -200000
