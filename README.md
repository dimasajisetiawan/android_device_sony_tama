# TWRP configuration for Sony Tama (SDM845) platform devices

## Supported Sony Snapdragon 845 based devices

- Xperia XZ2 H8216/H8266/H8296    => [akari](https://www.gsmarena.com/sony_xperia_xz2-9081.php)
- Xperia XZ2 Compact H8314/H8324  => [apollo](https://www.gsmarena.com/sony_xperia_xz2_compact-9082.php)
- Xperia XZ2 Premium H8116/H8166  => [aurora](https://www.gsmarena.com/sony_xperia_xz2_premium-9166.php)
- Xperia XZ3 H8416/H9436/H9493    => [akatsuki](https://www.gsmarena.com/sony_xperia_xz3-9232.php)

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
- [x] fastbootd (adb reboot fastboot)
- [ ] decrypt adoptable storage
- [x] reboot to EDL

## Clone manifest twrp-12.1

```bash
repo init -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-12.1
```

## Sync manifest twrp-12.1

```bash
repo sync -j$(nproc --all)
git clone https://github.com/minimal-manifest-twrp/android_device_common_version-info -b twrp-12.1 device/common/version-info
```

## Clone the device tree

```bash
git clone https://github.com/j4nn/android_device_sony_tama.git -b android-12.1 device/sony/tama
```

## Optional patch to support SODP roms too

```bash
patch -p1 < device/sony/tama/patches/vold-decryption-workaround-for-sodp-kernel.patch
```

## Build

```bash
unset JAVAC
unset JAVA_HOME
unset LEX
export ALLOW_MISSING_DEPENDENCIES=true
. build/envsetup.sh
export USE_CUSTOM_VERSION=true

lunch twrp_akari-userdebug; mka bootimage
lunch twrp_apollo-userdebug; mka bootimage
lunch twrp_aurora-userdebug; mka bootimage
lunch twrp_akatsuki-userdebug; mka bootimage
```

## Thanks

- [MartinX3](https://github.com/MartinX3) ([android9 twrp](https://github.com/MartinX3-AndroidDevelopment/TWRP_android_device_sony_akari_old) for tama devices including touch type detection)
- TWRP developers (other devices setup as a base template)
- Lineage OS developers (multiple picks from tama devices configs)

Please see commits history for proper attribution.
