include $(TOPDIR)/rules.mk

PKG_NAME:=brcmfmac-firmware-panther-x2

PKG_SOURCE_URL:=https://github.com/xiaomeng9597/brcmfmac_sdio-firmware.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=72b01a367f7e718250de12e7c0d5d335ab9866a8
PKG_MIRROR_HASH:=skip

include $(INCLUDE_DIR)/package.mk

define Package/brcmfmac-firmware-panther-x2
  SECTION:=firmware
  CATEGORY:=Firmware
  URL:=https://github.com/xiaomeng9597/brcmfmac_sdio-firmware.git
  TITLE:=Panther X2 BCM43430 Firmware
endef

define Build/Compile
	true
endef

define Package/brcmfmac-firmware-panther-x2/install
	$(INSTALL_DIR) $(1)/lib/firmware/brcm
	$(INSTALL_DATA) \
		$(PKG_BUILD_DIR)/BCM43430B0.hcd \
		$(1)/lib/firmware/brcm/BCM43430B0.hcd
	$(INSTALL_DATA) \
		$(PKG_BUILD_DIR)/brcmfmac43430-sdio.bin \
		$(1)/lib/firmware/brcm/brcmfmac43430-sdio.bin
	$(INSTALL_DATA) \
		$(PKG_BUILD_DIR)/brcmfmac43430-sdio.txt \
		$(1)/lib/firmware/brcm/brcmfmac43430-sdio.txt
	$(INSTALL_DATA) \
		$(PKG_BUILD_DIR)/brcmfmac43430-sdio.clm_blob \
		$(1)/lib/firmware/brcm/brcmfmac43430-sdio.clm_blob
	$(INSTALL_DATA) \
		$(PKG_BUILD_DIR)/brcmfmac43430-sdio.bin \
		$(1)/lib/firmware/brcm/brcmfmac43430-sdio.panther,x2.bin
	$(INSTALL_DATA) \
		$(PKG_BUILD_DIR)/brcmfmac43430-sdio.txt \
		$(1)/lib/firmware/brcm/brcmfmac43430-sdio.panther,x2.txt
	$(INSTALL_DATA) \
		$(PKG_BUILD_DIR)/brcmfmac43430-sdio.clm_blob \
		$(1)/lib/firmware/brcm/brcmfmac43430-sdio.panther,x2.clm_blob
endef

$(eval $(call BuildPackage,brcmfmac-firmware-panther-x2))
