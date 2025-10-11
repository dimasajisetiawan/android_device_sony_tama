# TWRP configuration for Sony Tama (sdm845) platform devices

## Checks

Blocking checks
- [x] Correct screen/recovery size
- [x] Working Touch, screen
- [x] Backup to internal/microSD
- [x] Restore from internal/microSD
- [x] reboot to system
- [x] ADB

Medium checks
- [x] update.zip sideload
- [x] UI colors (red/blue inversions)
- [x] Screen goes off and on
- [x] F2FS/EXT4 Support, exFAT/NTFS where supported
- [x] all important partitions listed in mount/backup lists
- [x] backup/restore to/from external (USB-OTG) storage
- [x] decrypt /data
- [x] Correct date
- [x] USB-OTG (flash drive)

Minor checks
- [x] MTP export
- [x] reboot to bootloader
- [x] reboot to recovery
- [x] poweroff
- [x] battery level
- [x] temperature
- [ ] encrypted backups
- [x] input devices via USB (USB-OTG) - keyboard and mouse
- [x] USB mass storage export
- [x] set brightness
- [x] vibrate
- [x] screenshot
- [x] partition SD card


## Clone manifest twrp-12.1

```bash
repo init -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-12.1
```

## Sync manifest twrp-12.1

```bash
repo sync -j$(nproc --all)
```

## Clone the device tree

```bash
git clone https://github.com/j4nn/android_device_sony_tama.git -b android-12.1 device/sony/tama
```

## Build

```bash
export ALLOW_MISSING_DEPENDENCIES=true; . build/envsetup.sh; lunch twrp_akari-userdebug; mka bootimage
```
