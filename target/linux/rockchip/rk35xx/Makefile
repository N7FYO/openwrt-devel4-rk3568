# SPDX-License-Identifier: GPL-2.0-only

include $(TOPDIR)/rules.mk

BOARD:=rk35xx
BOARDNAME:=RK35xx-Rockchip
FEATURES:=ext4 audio usb usbgadget display gpio fpu pci pcie rootfs-part boot-part squashfs
SUBTARGETS:=armv8

KERNEL_PATCHVER:=5.15

define Target/Description
	Build firmware image for Rockchip RK35xx  SoC devices.
endef

include $(INCLUDE_DIR)/target.mk

DEFAULT_PACKAGES += uboot-envtools partx-utils e2fsprogs mkf2fs kmod-gpio-button-hotplug

KERNELNAME:=Image dtbs

$(eval $(call BuildTarget))
