#!/bin/bash
#===============================================
# Description: DIY script
# File name: diy-script.sh
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#===============================================

# enable rk3568 model adc keys
cp -f $GITHUB_WORKSPACE/configfiles/adc-keys.txt adc-keys.txt
! grep -q 'adc-keys {' package/boot/uboot-rk35xx/src/arch/arm/dts/rk3568-easepi.dts && sed -i '/\"rockchip,rk3568\";/r adc-keys.txt' package/boot/uboot-rk35xx/src/arch/arm/dts/rk3568-easepi.dts

# update ubus git HEAD
cp -f $GITHUB_WORKSPACE/configfiles/ubus_Makefile package/system/ubus/Makefile

# 近期istoreos网站文件服务器不稳定，临时增加一个自定义下载网址
sed -i "s/push @mirrors, 'https:\/\/mirror2.openwrt.org\/sources';/&\\npush @mirrors, 'https:\/\/github.com\/xiaomeng9597\/files\/releases\/download\/iStoreosFile';/g" scripts/download.pl


# 修改内核配置文件
sed -i "/.*CONFIG_ROCKCHIP_RGA2.*/d" target/linux/rockchip/rk35xx/config-5.10
# sed -i "/# CONFIG_ROCKCHIP_RGA2 is not set/d" target/linux/rockchip/rk35xx/config-5.10
# sed -i "/CONFIG_ROCKCHIP_RGA2_DEBUGGER=y/d" target/linux/rockchip/rk35xx/config-5.10
# sed -i "/CONFIG_ROCKCHIP_RGA2_DEBUG_FS=y/d" target/linux/rockchip/rk35xx/config-5.10
# sed -i "/CONFIG_ROCKCHIP_RGA2_PROC_FS=y/d" target/linux/rockchip/rk35xx/config-5.10




# 替换dts文件
cp -f $GITHUB_WORKSPACE/configfiles/dts/rk3566-jp-tvbox.dts target/linux/rockchip/dts/rk3568/rk3566-jp-tvbox.dts

cp -f $GITHUB_WORKSPACE/configfiles/dts/rk3566-panther-x2.dts target/linux/rockchip/dts/rk3568/rk3566-panther-x2.dts

cp -f $GITHUB_WORKSPACE/configfiles/dts/rk3568-dg-nas-lite-core.dtsi target/linux/rockchip/dts/rk3568/rk3568-dg-nas-lite-core.dtsi
cp -f $GITHUB_WORKSPACE/configfiles/dts/rk3568-dg-nas-lite.dts target/linux/rockchip/dts/rk3568/rk3568-dg-nas-lite.dts

cp -f $GITHUB_WORKSPACE/configfiles/dts/rk3568-mrkaio-m68s-core.dtsi target/linux/rockchip/dts/rk3568/rk3568-mrkaio-m68s-core.dtsi
cp -f $GITHUB_WORKSPACE/configfiles/dts/rk3568-mrkaio-m68s.dts target/linux/rockchip/dts/rk3568/rk3568-mrkaio-m68s.dts
cp -f $GITHUB_WORKSPACE/configfiles/dts/rk3568-mrkaio-m68s-plus.dts target/linux/rockchip/dts/rk3568/rk3568-mrkaio-m68s-plus.dts



# 修改uhttpd配置文件，启用nginx
# sed -i "/.*uhttpd.*/d" .config
# sed -i '/.*\/etc\/init.d.*/d' package/network/services/uhttpd/Makefile
# sed -i '/.*.\/files\/uhttpd.init.*/d' package/network/services/uhttpd/Makefile
sed -i "s/:80/:81/g" package/network/services/uhttpd/files/uhttpd.config
sed -i "s/:443/:4443/g" package/network/services/uhttpd/files/uhttpd.config
cp -a $GITHUB_WORKSPACE/configfiles/etc/* package/base-files/files/etc/
# ls package/base-files/files/etc/




# 轮询检查ubus服务是否崩溃，崩溃就重启ubus服务，只针对rk3566机型，如黑豹X2和荐片TV盒子。
cp -f $GITHUB_WORKSPACE/configfiles/httpubus package/base-files/files/etc/init.d/httpubus
cp -f $GITHUB_WORKSPACE/configfiles/ubus-examine.sh package/base-files/files/bin/ubus-examine.sh
chmod 755 package/base-files/files/etc/init.d/httpubus
chmod 755 package/base-files/files/bin/ubus-examine.sh



# 集成黑豹X2和荐片TV盒子WiFi驱动，默认不启用WiFi
cp -a $GITHUB_WORKSPACE/configfiles/packages/* package/firmware/
cp -f $GITHUB_WORKSPACE/configfiles/opwifi package/base-files/files/etc/init.d/opwifi
chmod 755 package/base-files/files/etc/init.d/opwifi
# sed -i "s/wireless.radio\${devidx}.disabled=1/wireless.radio\${devidx}.disabled=0/g" package/kernel/mac80211/files/lib/wifi/mac80211.sh



# 集成CPU性能跑分脚本
cp -f $GITHUB_WORKSPACE/configfiles/coremark/coremark-arm64 package/base-files/files/bin/coremark-arm64
cp -f $GITHUB_WORKSPACE/configfiles/coremark/coremark-arm64.sh package/base-files/files/bin/coremark.sh
chmod 755 package/base-files/files/bin/coremark-arm64
chmod 755 package/base-files/files/bin/coremark.sh


# iStoreOS-settings
git clone --depth=1 -b main https://github.com/xiaomeng9597/istoreos-settings package/default-settings


# 定时限速插件
git clone --depth=1 https://github.com/sirpdboy/luci-app-eqosplus package/luci-app-eqosplus


# 添加imb3588
echo "
define Device/yx_imb3588
\$(call Device/rk3588)
  DEVICE_VENDOR := YX
  DEVICE_MODEL := IMB3588
  DEVICE_PACKAGES := kmod-r8125 kmod-nvme kmod-scsi-core kmod-hwmon-pwmfan kmod-thermal kmod-rkwifi-bcmdhd-pcie rkwifi-firmware-ap6275p
  SUPPORTED_DEVICES += yx,imb3588
  DEVICE_DTS := rk3588-yx-imb3588
endef
TARGET_DEVICES += yx_imb3588
" >>  target/linux/rockchip/image/rk35xx.mk

#sed -i "s/armsom,sige7-v1|/yx,imb3588|armsom,sige7-v1|/g" target/linux/rockchip/rk35xx/base-files/etc/board.d/02_network

# 添加a588
echo "
define Device/dc_a588
\$(call Device/rk3588)
  DEVICE_VENDOR := DC
  DEVICE_MODEL := A588
  DEVICE_PACKAGES := kmod-r8125 kmod-nvme kmod-scsi-core kmod-hwmon-pwmfan kmod-thermal kmod-rkwifi-bcmdhd-pcie rkwifi-firmware-ap6275p
  SUPPORTED_DEVICES += dc,a588
  DEVICE_DTS := rk3588-dc-a588
endef
TARGET_DEVICES += dc_a588
" >>  target/linux/rockchip/image/rk35xx.mk

#sed -i "s/armsom,sige7-v1|/yx,imb3588|dc,a588|armsom,sige7-v1|/g" target/linux/rockchip/rk35xx/base-files/etc/board.d/02_network

# 添加e88a
echo "
define Device/jwipc_jea-e88a
\$(call Device/rk3588)
  DEVICE_VENDOR := JWIPC
  DEVICE_MODEL := jea-e88a
  DEVICE_PACKAGES := kmod-nvme kmod-scsi-core kmod-hwmon-pwmfan kmod-thermal
  SUPPORTED_DEVICES += jwipc,jea-e88a
  DEVICE_DTS := rk3588-jwipc-e88a
endef
TARGET_DEVICES += jwipc_jea-e88a
" >>  target/linux/rockchip/image/rk35xx.mk

sed -i "s/armsom,sige7-v1|/jwipc,jea-e88a|yx,imb3588|dc,a588|armsom,sige7-v1|/g" target/linux/rockchip/rk35xx/base-files/etc/board.d/02_network

echo " 
CONFIG_TARGET_DEVICE_rockchip_rk35xx_DEVICE_yx_imb3588=y
CONFIG_TARGET_DEVICE_rockchip_rk35xx_DEVICE_dc_a588=y
CONFIG_TARGET_DEVICE_rockchip_rk35xx_DEVICE_jwipc_jea-e88a=y
" >>  .config

# 添加dts
cp -f $GITHUB_WORKSPACE/configfiles/rk3588-yx-imb3588.dts target/linux/rockchip/dts/rk3588/rk3588-yx-imb3588.dts
cp -f $GITHUB_WORKSPACE/configfiles/rk3588-dc-a588.dts target/linux/rockchip/dts/rk3588/rk3588-dc-a588.dts
cp -f $GITHUB_WORKSPACE/configfiles/rk3588-jwipc-e88a.dts target/linux/rockchip/dts/rk3588/rk3588-jwipc-e88a.dts

#添加qmodem
git clone --depth=1 -b main https://github.com/FUjr/QModem feeds/modem
echo "
CONFIG_PACKAGE_luci-i18n-qmodem-zh-cn=y
CONFIG_PACKAGE_luci-i18n-qmodem-hc-zh-cn=y
CONFIG_PACKAGE_luci-i18n-qmodem-mwan-zh-cn=y
# CONFIG_PACKAGE_luci-i18n-qmodem-ru is not set
CONFIG_PACKAGE_luci-i18n-qmodem-sms-zh-cn=y
CONFIG_PACKAGE_luci-app-qmodem=y
CONFIG_PACKAGE_luci-app-modem=n
CONFIG_PACKAGE_luci-app-qmodem_INCLUDE_vendor-qmi-wwan=y
# CONFIG_PACKAGE_luci-app-qmodem_INCLUDE_generic-qmi-wwan is not set
CONFIG_PACKAGE_luci-app-qmodem_USE_TOM_CUSTOMIZED_QUECTEL_CM=y
# CONFIG_PACKAGE_luci-app-qmodem_USING_QWRT_QUECTEL_CM_5G is not set
# CONFIG_PACKAGE_luci-app-qmodem_USING_NORMAL_QUECTEL_CM is not set
# CONFIG_PACKAGE_luci-app-qmodem_INCLUDE_ADD_PCI_SUPPORT is not set
# CONFIG_PACKAGE_luci-app-qmodem_INCLUDE_ADD_QFIREHOSE_SUPPORT is not set
CONFIG_PACKAGE_luci-app-qmodem-hc=y
CONFIG_PACKAGE_luci-app-qmodem-mwan=y
CONFIG_PACKAGE_luci-app-qmodem-sms=y
CONFIG_PACKAGE_luci-app-qmodem-ttl=y
CONFIG_PACKAGE_qmodem=y
CONFIG_PACKAGE_quectel-CM-5G=y
CONFIG_PACKAGE_quectel-CM-5G-M=y
" >> .config
