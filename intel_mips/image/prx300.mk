ifeq ($(SUBTARGET),prx300)
include $(INCLUDE_DIR)/version.mk

FAKEROOT_CMD:=$(if $(CONFIG_PACKAGE_ugw-fakeroot), \
	ALTPATH="$(STAGING_DIR_ROOT)" CONFFILE="$(PWD)/image/fakeroot-prx300.conf" \
	fakeroot -- $(STAGING_DIR_HOST)/bin/fakeroot.sh)

# NAND configs are based on MX35LF1GEAB flash
# Max volume 32 MiB (256 blocks)
# Journal size 1 MiB to fit in small (<4 MiB) image
define Device/PRX_GENERIC
  $(Device/lantiqFullImage)
  IMAGE_SIZE := 64512k
  KERNEL_LOADADDR := 0xa0020000
  KERNEL_ENTRY := 0xa0020000
  KERNEL_INITRAMFS := kernel-bin | append-dtb | lzma | uImage lzma
  UIMAGE_NAME:=$(if $(VERSION_IMAGE_SED),$(VERSION_IMAGE_SED))
  FAKED_ENV := $(FAKEROOT_CMD)
endef

define Device/PRX321_EVA_ETH
  $(Device/PRX_GENERIC)
  $(Device/NAND)
  IMAGE/kernel.bin := append-kernel
  IMAGE/nand.rootfs := append-rootfs
  IMAGES += kernel.bin nand.rootfs
  FILESYSTEMS := squashfs
  PAGESIZE := 2048
  BLOCKSIZE := 128k
  SUBPAGESIZE := 2048
  DEVICE_DTS := prx321-eva-eth
  DEVICE_TITLE := PRX321 EVA Ethernet WAN
endef
TARGET_DEVICES += PRX321_EVA_ETH

define Device/PRX321_EVA_GPHY_ETH
  $(Device/PRX_GENERIC)
  $(Device/NAND)
  IMAGE/kernel.bin := append-kernel
  IMAGE/nand.rootfs := append-rootfs
  IMAGES += kernel.bin nand.rootfs
  FILESYSTEMS := squashfs
  PAGESIZE := 2048
  BLOCKSIZE := 128k
  SUBPAGESIZE := 2048
  DEVICE_DTS := prx321-eva-gphy-eth
  DEVICE_TITLE := PRX321 EVA GPHY Ethernet WAN
endef
TARGET_DEVICES += PRX321_EVA_GPHY_ETH

define Device/PRX321_EVA_PCIE
  $(Device/PRX_GENERIC)
  $(Device/NAND)
  IMAGE/kernel.bin := append-kernel
  IMAGE/nand.rootfs := append-rootfs
  IMAGES += kernel.bin nand.rootfs
  FILESYSTEMS := squashfs
  PAGESIZE := 2048
  BLOCKSIZE := 128k
  SUBPAGESIZE := 2048
  DEVICE_DTS := prx321-eva-pcie
  DEVICE_TITLE := PRX321 EVA PCIe
endef
TARGET_DEVICES += PRX321_EVA_PCIE

define Device/PRX321_EVA_QSPI_ETH
  $(Device/PRX_GENERIC)
  $(Device/NAND)
  IMAGE/kernel.bin := append-kernel
  IMAGE/nand.rootfs := append-rootfs
  IMAGES += kernel.bin nand.rootfs
  FILESYSTEMS := squashfs
  PAGESIZE := 2048
  BLOCKSIZE := 128k
  SUBPAGESIZE := 2048
  DEVICE_DTS := prx321-eva-qspi-eth
  DEVICE_TITLE := PRX321 EVA QSPI Ethernet WAN
endef
TARGET_DEVICES += PRX321_EVA_QSPI_ETH

define Device/PRX321_EVA_QSPI_PON
  $(Device/PRX_GENERIC)
  $(Device/NAND)
  FILESYSTEMS := squashfs
  DEVICE_DTS := prx321-eva-qspi-pon
  DEVICE_TITLE := PRX321 EVA QSPI PON WAN
endef
TARGET_DEVICES += PRX321_EVA_QSPI_PON

define Device/PRX321_EVA_PON
  $(Device/PRX_GENERIC)
  $(Device/NAND)
  FILESYSTEMS := squashfs
  DEVICE_DTS := prx321-eva-pon
  DEVICE_TITLE := PRX321 EVA PON WAN
endef
TARGET_DEVICES += PRX321_EVA_PON

define Device/PRX321_SFU_ETH
  $(Device/PRX_GENERIC)
  $(Device/NAND)
  FILESYSTEMS := squashfs
  DEVICE_DTS := prx321-sfu-eth
  DEVICE_TITLE := PRX321 SFU Ethernet WAN
endef
TARGET_DEVICES += PRX321_SFU_ETH

define Device/PRX321_SFU_PON
  $(Device/PRX_GENERIC)
  $(Device/NAND)
  FILESYSTEMS := squashfs
  DEVICE_DTS := prx321-sfu-pon
  DEVICE_TITLE := PRX321 SFU PON WAN
endef
TARGET_DEVICES += PRX321_SFU_PON

define Device/PRX321_SFU_QSPI_PON
  $(Device/PRX_GENERIC)
  $(Device/NAND)
  FILESYSTEMS := squashfs
  DEVICE_DTS := prx321-sfu-qspi-pon
  DEVICE_TITLE := PRX321 SFU QSPI PON WAN
endef
TARGET_DEVICES += PRX321_SFU_QSPI_PON

define Device/PRX321_SFU_QSPI_ETH
  $(Device/PRX_GENERIC)
  $(Device/NAND)
  FILESYSTEMS := squashfs
  DEVICE_DTS := prx321-sfu-qspi-eth
  DEVICE_TITLE := PRX321 SFU QSPI ETH WAN
endef
TARGET_DEVICES += PRX321_SFU_QSPI_ETH

define Device/PRX126_SFP_EVA_PON
  $(Device/PRX_GENERIC)
  $(Device/NAND)
  FILESYSTEMS := squashfs
  DEVICE_DTS := prx126-sfp-eva-pon
  DEVICE_TITLE := PRX126 SFP EVA PON WAN
endef
TARGET_DEVICES += PRX126_SFP_EVA_PON

define Device/PRX126_SFP_EVA_ETH
  $(Device/PRX_GENERIC)
  $(Device/NAND)
  FILESYSTEMS := squashfs
  DEVICE_DTS := prx126-sfp-eva-eth
  DEVICE_TITLE := PRX126 SFP EVA ETH WAN
endef
TARGET_DEVICES += PRX126_SFP_EVA_ETH

define Device/PRX126_SFP_PON
  $(Device/PRX_GENERIC)
  $(Device/NAND)
  FILESYSTEMS := squashfs
  DEVICE_DTS := prx126-sfp-pon
  DEVICE_TITLE := PRX126 SFP PON WAN
endef
TARGET_DEVICES += PRX126_SFP_PON

define Device/PRX321_SFU_QSPI_PON_FPGA
  $(Device/PRX_GENERIC)
  $(Device/NAND)
  FILESYSTEMS := squashfs
  DEVICE_DTS := prx321-sfu-qspi-pon-fpga
  DEVICE_TITLE := PRX321 SFU QSPI PON FPGA
endef
TARGET_DEVICES += PRX321_SFU_QSPI_PON_FPGA

define Device/PRX120_SFU_QSPI_PON
  $(Device/PRX_GENERIC)
  $(Device/NAND)
  FILESYSTEMS := squashfs
  DEVICE_DTS := prx120-sfu-qspi-pon
  DEVICE_TITLE := PRX120 SFU QSPI PON WAN
endef
TARGET_DEVICES += PRX120_SFU_QSPI_PON

define Device/PRX321_GW_11AX
  $(Device/PRX_GENERIC)
  $(Device/NAND)
  FILESYSTEMS := squashfs
  DEVICE_DTS := prx321-gw-11ax
  DEVICE_TITLE := PRX321 GW 11AX
  ROOTFS_PREPARE := add-servicelayer-schema
  DEVICE_PACKAGES := $(WAV600_PACKAGES_UCI) $(WAV600_UGW_PACKAGES_UCI) $(PON_PACKAGES)
endef
TARGET_DEVICES += PRX321_GW_11AX

define Device/PRX321_GW_11AX_V2
  $(Device/PRX_GENERIC)
  $(Device/NAND)
  FILESYSTEMS := squashfs
  DEVICE_DTS := prx321-gw-11ax-v2
  DEVICE_TITLE := PRX321 GW 11AX V2
  ROOTFS_PREPARE := add-servicelayer-schema
  DEVICE_PACKAGES := $(WAV600_PACKAGES_UCI) $(WAV600_UGW_PACKAGES_UCI) $(PON_PACKAGES)
endef
TARGET_DEVICES += PRX321_GW_11AX_V2

define Device/PRX321_GW_11AX_SP_PON
  $(Device/PRX_GENERIC)
  $(Device/NAND)
  FILESYSTEMS := squashfs
  DEVICE_DTS := prx321-gw-11ax-sp-pon
  DEVICE_TITLE := PRX321 GW 11AX SP PON
  ROOTFS_PREPARE := add-servicelayer-schema
  DEVICE_PACKAGES := $(UGW_PACKAGES) $(WAV600_PACKAGES_UCI) $(WAV600_UGW_PACKAGES_UCI) $(PON_PACKAGES) \
			$(DSL_CPE_GFAST_PACKAGES_PRX) $(DSL_CPE_GFAST_PACKAGES_DEBUG)
endef
TARGET_DEVICES += PRX321_GW_11AX_SP_PON

define Device/PRX321_GW_11AX_SP_ETH
  $(Device/PRX_GENERIC)
  $(Device/NAND)
  FILESYSTEMS := squashfs
  DEVICE_DTS := prx321-gw-11ax-sp-eth
  DEVICE_TITLE := PRX321 GW 11AX SP ETH
  ROOTFS_PREPARE := add-servicelayer-schema
  DEVICE_PACKAGES := $(UGW_PACKAGES) $(WAV600_PACKAGES_UCI) $(WAV600_UGW_PACKAGES_UCI) \
			$(DSL_CPE_GFAST_PACKAGES_PRX) $(DSL_CPE_GFAST_PACKAGES_DEBUG)
endef
TARGET_DEVICES += PRX321_GW_11AX_SP_ETH

define Device/PRX321_GW_11AX_SP_ETH_WAN_GPHY
  $(Device/PRX_GENERIC)
  $(Device/NAND)
  FILESYSTEMS := squashfs
  DEVICE_DTS := prx321-gw-11ax-sp-eth-wan-gphy
  DEVICE_TITLE := PRX321 GW 11AX SP ETH WAN GPHY
  ROOTFS_PREPARE := add-servicelayer-schema
  DEVICE_PACKAGES := $(UGW_PACKAGES_SDL) $(WAV600_PACKAGES_UCI) $(WAV600_UGW_PACKAGES_UCI)
endef
TARGET_DEVICES += PRX321_GW_11AX_SP_ETH_WAN_GPHY

endif # end prx300

ifeq ($(SUBTARGET),prx300_4kec)

define Device/SFU_EVA_bootcore
  $(Device/lantiqBootImage)
  IMAGE_SIZE := 16512k
  DEVICE_DTS := prx321-eva-bootcore
  DEVICE_TITLE := PRX321 SFU Bootcore SFU EVA
  UIMAGE_NAME := MIPS 4Kec Bootcore
  KERNEL_LOADADDR := 0x88000000
  KERNEL_ENTRY := 0x88000000
endef
TARGET_DEVICES += SFU_EVA_bootcore

endif # end prx300_4kec
