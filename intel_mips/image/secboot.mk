SECUREBOOT:=
ifeq ($(CONFIG_SECBOOT),y)
ifeq ($(CONFIG_KEYS_PROVISION),y)
SECUREBOOT:=y
endif
endif

ifeq ($(SECUREBOOT),y)
ifeq ($(CONFIG_CERTIFICATION_SUPPORT),y)
	CERT :=	-cert $(CONFIG_CERTIFICATION)
else
	CERT:=
endif

define Build/sign-image
	$(CONFIG_SIGNTOOL)  sign -type BLw  -infile $@ \
		-prikey $(CONFIG_PRIVATE_KEY) \
		-wrapkey $(CONFIG_PROD_UNIQUE_KEY) \
		-attribute rollback=2 \
		-attribute 0x80000000=$(KERNEL_ENTRY) \
		-attribute 0x80000001=0x00000001 \
		-attribute 0x80000002=$(KERNEL_LOADADDR) \
		-encattr \
		$(CERT) \
		-kdk \
		-pubkeytype otp \
		-algo aes256 \
		-outfile $@.tmp
	mv $@.tmp $@
endef

define Build/sign-add-header
	mkimage -A mips -O linux -T kernel -a 0x00 -C none \
		-e 0x00 -n 'OpenWrt fullimage' \
		-d $@ $@.tmp
	mv $@.tmp $@
endef

else

define Build/sign-image
endef

define Build/sign-add-header
endef

endif
