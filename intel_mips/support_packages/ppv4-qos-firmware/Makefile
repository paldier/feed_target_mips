# Copyright (C) 2018 Intel Corporation
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ppv4-qos-firmware
PKG_BASE_NAME:=ppv4-qos-fw
PKG_VERSION:=1.6.1
PKG_POSTFIX:=b
PKG_RELEASE:=1
PKG_SOURCE:=$(PKG_BASE_NAME)-$(PKG_VERSION).$(PKG_POSTFIX).tar.gz
PKG_SOURCE_URL:=http://localhost
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_BASE_NAME)-$(PKG_VERSION)
PKG_LICENSE:=Intel
PKG_LICENSE_FILES:=LICENSE
PKG_HASH:=d8f63903d2f2c9fc311d717a19108b924f02c076f99397dcd7872beae6508be5

# Prevent OpenWrt from stripping this firmware binary
STRIP=/bin/true
RSTRIP=/bin/true

include $(INCLUDE_DIR)/package-version-override.mk
include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  TITLE:=PPv4 QoS Firmware
  SECTION:=firmware
  CATEGORY:=Intel
  MAINTAINER:=Intel
  SUBMENU:=Firmware
  DEPENDS:=@TARGET_intel_mips_prx300
endef

define Package/$(PKG_NAME)/config
  $(call Package/$(PKG_NAME)/override_version)
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/lib/firmware/
	$(CP) $(PKG_BUILD_DIR)/ppv4-qos-fw.elf $(1)/lib/firmware/ppv4-qos-fw.elf
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
