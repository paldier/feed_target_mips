#
# Copyright (C) 2010-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

# boards missing since devicetree update
#EASY50712 ARV3527P

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk
-include ./packages.mk
include secboot.mk

KERNEL_LOADADDR := 0x80002000
KERNEL_ENTRY := 0x80002000

ifeq ($(SUBTARGET),xway)
  UBIFS_OPTS := -m 512 -e 15872 -c 1959
else
  UBIFS_OPTS := -m 2048 -e 126KiB -c 4096
endif

define Image/Prepare/add-servicelayer-schema
	$(eval vendordir=$(1)/$(call qstrip,$(VENDOR_PATH)))
	$(eval xmlsmerge=LD_LIBRARY_PATH="$(STAGING_DIR)/host/lib/:${LD_LIBRARY_PATH}" $(STAGING_DIR_HOST)/bin/python \
		$(STAGING_DIR_HOST)/bin/merge.py -v $(STAGING_DIR_HOST)/bin/target_validate.xsd)
	- cd $(vendordir)/xml/ && { \
		ls ./*_control.xml ./*_data.xml >/dev/null 2>&1 && { \
			$(xmlsmerge) *_control*.xml -o=control.xml || exit 1; \
			$(CP) $(vendordir)/xml/control.xml  $(vendordir)/csd/etc/ctrlcfg; \
			$(xmlsmerge) *_data*.xml -o=data.xml || exit 1; \
			$(SED) "s/\(<HwModelName.*>\).*\(<.*\)/\1$(CONFIG_HW_MODEL_NAME)\2/" data.xml; \
			$(SED) "s/\(<HwVersion.*>\).*\(<.*\)/\1$(CONFIG_HW_MODEL_VERSION)\2/" data.xml; \
			$(SED) "s/\(<SwUpdtTimeStamp.*>\).*\(<.*\)/\1$(TIME_STAMP)\2/" data.xml; \
			$(CP) $(vendordir)/xml/data.xml  $(vendordir)/csd/etc/datacfg; \
			rm -f $(vendordir)/xml/*; \
		} \
	}
endef

define Image/Prepare
	$(if $(TARGET_PER_DEVICE_ROOTFS),,$(if $(CONFIG_PACKAGE_csd),$(call Image/Prepare/add-servicelayer-schema,$(TARGET_DIR))))
endef

# Lantiq fullimage format, $(1) padding to be used.
define Build/fullimage
	# Add padding to make the next image start at a specified byte boundary.
	dd if=$(IMAGE_ROOTFS) of=$@.rootfs bs=$(1) conv=sync;
	mkimage -A mips -O linux -C lzma -T filesystem -a 0x00  \
		-e 0x00 -n 'LEDE RootFS' \
		-d $@.rootfs $@.rootfs.pad

	cat $(IMAGE_KERNEL) $@.rootfs.pad > $@.tmp

	mkimage -A $(LINUX_KARCH) -O linux -T multi -a 0x00 -C none \
		-e 0x00 \
		-n '$(if $(UIMAGE_NAME),$(UIMAGE_NAME),OpenWrt fullimage)' \
		-d $@.tmp $@

	rm $@.rootfs
	rm $@.rootfs.pad
	rm $@.tmp
endef

# Shared device definition: applies to every defined device
define Device/Default
  PROFILES = Default
  KERNEL_DEPENDS = $$(wildcard ../dts/$$(DEVICE_DTS).dts)
  KERNEL_INITRAMFS_NAME = $$(KERNEL_NAME)-initramfs
  KERNEL := kernel-bin | append-dtb | lzma | uImage lzma
  KERNEL_INITRAMFS := kernel-bin | append-dtb | lzma | uImage lzma
  FILESYSTEMS := squashfs
  DEVICE_DTS := $(1)
  DEVICE_DTS_DIR := ../dts
  IMAGE_SIZE :=
  SUPPORTED_DEVICES = $$(DEVICE_DTS)
  IMAGES := sysupgrade.bin
  IMAGE/sysupgrade.bin := append-kernel | append-rootfs | pad-rootfs | append-metadata | check-size $$$$(IMAGE_SIZE)
endef
DEVICE_VARS += IMAGE_SIZE

define Device/NAND/xrx500
  BLOCKSIZE := 128k
  PAGESIZE := 2048
  SUBPAGESIZE := 512
  FILESYSTEMS += ubifs
endef

define Device/NAND
  $(Device/NAND/$(SUBTARGET))
  IMAGE/sysupgrade.bin := sysupgrade-tar | append-metadata
endef

# For Lantiq UGW U-boot LANTIQ-v-2.3.138 and older (UGW 7.2 GA and older)
define Device/lantiqFullImageOld
  KERNEL := kernel-bin | append-dtb | lzma | uImage lzma | pad-offset 4 0
  IMAGES := sysupgrade.bin fullimage.img
  IMAGE/fullimage.img := fullimage 4 | check-size $$$$(IMAGE_SIZE)
endef

# For Lantiq UGW U-boot LANTIQ-v-2.3.139 and more recent (UGW 7.2 PR1 and up)
define Device/lantiqFullImage
  KERNEL := kernel-bin | append-dtb | lzma $(if $(SECUREBOOT), | pad-offset 4k 64) | pad-offset 16 0 |uImage lzma
  IMAGES := sysupgrade.bin fullimage.img $(if $(SECUREBOOT), fullimage-secure.img)
  IMAGE/fullimage.img := fullimage 16 | check-size $$$$(IMAGE_SIZE)
  IMAGE/fullimage-secure.img := append-kernel | append-rootfs | sign-image | sign-add-header | check-size $$$$(IMAGE_SIZE)
endef

define Device/lantiqBootImage
  KERNEL_INITRAMFS := kernel-bin | append-dtb $(if $(SECUREBOOT), | sign-image) | uImage none
endef

include falcon.mk
include xrx500.mk
include axp.mk
-include rax40.mk
-include xdr3020.mk
include svip_be.mk
include svip_le.mk

$(eval $(call BuildImage))
