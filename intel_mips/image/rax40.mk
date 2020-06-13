ifeq ($(SUBTARGET),xrx500)

define Build/rax40sign
   rax40sign $@
   mv $@.pega $@
endef

define Device/NETGEAR_RAX40
  $(Device/xrx500)
  DEVICE_DTS := netgear_rax40
  DEVICE_TITLE := Netgear RAX40
  DEVICE_PACKAGES := $(OWRT_PACKAGES) $(DSL_CPE_PACKAGES)
  IMAGES := sysupgrade.bin fullimage.img fullimage.signed
  IMAGE/fullimage.signed = fullimage 16 | check-size $$$$(IMAGE_SIZE) | rax40sign
endef
TARGET_DEVICES += NETGEAR_RAX40

endif
