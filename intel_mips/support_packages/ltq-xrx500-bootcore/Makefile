#
# Openwrt Makefile
#
#### Includes ###################################
include $(TOPDIR)/rules.mk

#### Package Info ###############################
PKG_NAME:=ltq-xrx500-bootcore
PKG_RELEASE:=1
PKG_DEFAULT_CUSTOM_SOURCE_DIR:=$(BUILD_DIR_BASE)/xRX500_BootCore
PKG_TARGETS:=bin

include $(INCLUDE_DIR)/package.mk

PKG_BUILD_PARALLEL:=1

define Package/$(PKG_NAME)
	SECTION:=utils
	CATEGORY:=Lantiq
	SUBMENU:=Enable xRX500 BootCore build
	TITLE:=Lantiq xRX500 BootCore environment build
	URL:=http://www.lantiq.com
	MAINTAINER:=Lantiq
	MENU:=1
endef

define Package/$(PKG_NAME)/description
	This package is for building xRX500 BootCore model.
endef

BOOTCORE_SUFFIX:=$(shell echo $(CONFIG_XRX500_BOOTCORE_MODEL) |tr '[:upper:]' '[:lower:]')

### Menuconfig ##################################
define Package/$(PKG_NAME)/config
	menu "xRX500 Boot Core features"
		depends on PACKAGE_$(PKG_NAME)
		config XRX500_BOOTCORE_MODEL
		string "xrx500 Bootcore Model name"
		default ""
		help
		  Specify xrx500 Boot core model name for build
	endmenu
endef

#### Target Rules ###############################

define Build/Clean
	@rm -rf $(PKG_DEFAULT_CUSTOM_SOURCE_DIR)
	@rm -rf $(PKG_BUILD_DIR)
	@rm -rf $(BUILD_DIR_BASE)/*$(BOOTCORE_SUFFIX)
	@rm -rf $(TOPDIR)/staging_dir/*$(BOOTCORE_SUFFIX)
endef

define Build/Prepare
	echo Build/Prepare: ltq_bootcore_env_prepare.sh $(TOPDIR) $(PKG_BUILD_DIR)
	$(SHELL) ltq_bootcore_env_prepare.sh $(TOPDIR) $(PKG_BUILD_DIR)
endef

# no need to configure (./configure not existing anyway)
define Build/Configure
endef

# avoid exporting setting for cross-compilation, will break tools (and toolchain?) builds
define Build/Exports
endef

# override some variables and undefine others
MAKE_VARS:=OPENWRT_BUILD=0
MAKE_FLAGS:=-s V=$(OPENWRT_VERBOSE)

override undefine CFLAGS
override undefine GCC_HONOUR_COPTS

define Build/Compile
	$(call Build/Compile/Default)
endef

define Package/$(PKG_NAME)/install
	mkdir -p $(1)
	cp -f $(PKG_DEFAULT_CUSTOM_SOURCE_DIR)/bin/targets/$(BOARD)/$(SUBTARGET)_4kec/*initramfs* $(1)/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
