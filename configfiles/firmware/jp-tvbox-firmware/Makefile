include $(TOPDIR)/rules.mk

PKG_NAME:=brcmfmac-firmware-jp-tvbox

PKG_SOURCE_URL:=https://github.com/xiaomeng9597/brcmfmac_sdio-firmware.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=72b01a367f7e718250de12e7c0d5d335ab9866a8
PKG_MIRROR_HASH:=skip

include $(INCLUDE_DIR)/package.mk

define Package/brcmfmac-firmware-jp-tvbox
  SECTION:=firmware
  CATEGORY:=Firmware
  URL:=https://github.com/xiaomeng9597/brcmfmac_sdio-firmware.git
  TITLE:=JP TVBOX BCM4339 Firmware
endef

define Build/Compile
	true
endef

define Package/brcmfmac-firmware-jp-tvbox/install
	$(INSTALL_DIR) $(1)/lib/firmware/brcm
	$(INSTALL_DATA) \
		$(PKG_BUILD_DIR)/BCM4339A0.hcd \
		$(1)/lib/firmware/brcm/BCM4339A0.hcd
	$(INSTALL_DATA) \
		$(PKG_BUILD_DIR)/brcmfmac4339-sdio.bin \
		$(1)/lib/firmware/brcm/brcmfmac4339-sdio.bin
	$(INSTALL_DATA) \
		$(PKG_BUILD_DIR)/brcmfmac4339-sdio.txt \
		$(1)/lib/firmware/brcm/brcmfmac4339-sdio.txt
	$(INSTALL_DATA) \
		$(PKG_BUILD_DIR)/brcmfmac4339-sdio.bin \
		$(1)/lib/firmware/brcm/brcmfmac4339-sdio.jp,tvbox.bin
	$(INSTALL_DATA) \
		$(PKG_BUILD_DIR)/brcmfmac4339-sdio.txt \
		$(1)/lib/firmware/brcm/brcmfmac4339-sdio.jp,tvbox.txt
endef

$(eval $(call BuildPackage,brcmfmac-firmware-jp-tvbox))
