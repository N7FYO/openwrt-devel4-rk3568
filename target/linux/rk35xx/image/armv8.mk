# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2020 Tobias Maedel

# FIT will be loaded at 0x02080000. Leave 16M for that, align it to 2M and load the kernel after it.

# Updated and revised 2023 by TahomaSoft.com

# Check the pine64-img below
# Changed label to rk35xx-img

KERNEL_LOADADDR := 0x03200000


define Device/linkstar_common
  DEVICE_VENDOR := LinkStar
  SOC := rk3568
  UBOOT_DEVICE_NAME := opc-h68k-rk3568
  IMAGE/sysupgrade.img.gz := boot-common | boot-script mmc | rk35xx-img | gzip | append-metadata
  DEVICE_PACKAGES := kmod-ata-ahci-platform kmod-mt7921e kmod-r8125 kmod-usb-serial-cp210x wpad-openssl ethtool
endef

define Device/linkstar_common
  DEVICE_VENDOR := LinkStar
  SOC := rk3568
  UBOOT_DEVICE_NAME := opc-h68k-rk3568
  IMAGE/sysupgrade.img.gz := boot-common | boot-script mmc | rk35xx-img | gzip | append-metadata
  DEVICE_PACKAGES := kmod-ata-ahci-platform kmod-mt7921e kmod-r8125 kmod-usb-serial-cp210x wpad-openssl ethtool
endef

define Device/linkstar_opc-h68k
$(call Device/linkstar_common)
  DEVICE_MODEL := H68K
endef
TARGET_DEVICES += linkstar_opc-h68k
