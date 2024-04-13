#!/bin/bash
#===============================================
# Description: DIY script
# File name: diy-script.sh
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#===============================================

# 移植黑豹x2

# rm -f target/linux/rockchip/image/rk35xx.mk
# cp -f $GITHUB_WORKSPACE/files/rk35xx.mk target/linux/rockchip/image/rk35xx.mk


# rm -f target/linux/rockchip/rk35xx/base-files/lib/board/init.sh
# cp -f $GITHUB_WORKSPACE/files/init.sh target/linux/rockchip/rk35xx/base-files/lib/board/init.sh


# rm -f target/linux/rockchip/rk35xx/base-files/etc/board.d/02_network
# cp -f $GITHUB_WORKSPACE/files/02_network target/linux/rockchip/rk35xx/base-files/etc/board.d/02_network


# sed -i "s/option\s*script_timeout\s*60/option script_timeout 360/g" package/network/services/uhttpd/files/uhttpd.config




# 修改内核配置文件
# rm -f target/linux/rockchip/rk35xx/config-5.10
# cp -f $GITHUB_WORKSPACE/files/config-5.10 target/linux/rockchip/rk35xx/config-5.10
sed -i "/# CONFIG_ROCKCHIP_RGA2 is not set/d" target/linux/rockchip/rk35xx/config-5.10
sed -i "/CONFIG_ROCKCHIP_RGA2_DEBUGGER=y/d" target/linux/rockchip/rk35xx/config-5.10
sed -i "/CONFIG_ROCKCHIP_RGA2_DEBUG_FS=y/d" target/linux/rockchip/rk35xx/config-5.10
sed -i "/CONFIG_ROCKCHIP_RGA2_PROC_FS=y/d" target/linux/rockchip/rk35xx/config-5.10




# 替换dts文件
cp -f $GITHUB_WORKSPACE/files/rk3566-jp-tvbox.dts target/linux/rockchip/dts/rk3568/rk3566-jp-tvbox.dts

cp -f $GITHUB_WORKSPACE/files/rk3566-panther-x2.dts target/linux/rockchip/dts/rk3568/rk3566-panther-x2.dts







# 增加ido3568 DG NAS
echo -e "\\ndefine Device/dg_nas
\$(call Device/rk3568)
  DEVICE_VENDOR := DG
  DEVICE_MODEL := NAS
  DEVICE_DTS := rk3568-firefly-roc-pc-se
  SUPPORTED_DEVICES += dg,nas
  DEVICE_PACKAGES := kmod-nvme kmod-scsi-core
endef
TARGET_DEVICES += dg_nas" >> target/linux/rockchip/image/rk35xx.mk



sed -i "s/panther,x2|\\\/panther,x2|\\\\\n	dg,nas|\\\/g" target/linux/rockchip/rk35xx/base-files/lib/board/init.sh

sed -i "s/panther,x2|\\\/panther,x2|\\\\\n	dg,nas|\\\/g" target/linux/rockchip/rk35xx/base-files/etc/board.d/02_network


cp -f $GITHUB_WORKSPACE/files/rk3568-firefly-roc-pc-se-core.dtsi target/linux/rockchip/dts/rk3568/rk3568-firefly-roc-pc-se-core.dtsi

cp -f $GITHUB_WORKSPACE/files/rk3568-firefly-roc-pc-se.dts target/linux/rockchip/dts/rk3568/rk3568-firefly-roc-pc-se.dts


#增加一键补全WiFi脚本进系统里
cp -f $GITHUB_WORKSPACE/files/brcmfmac43430-sdio-panther-x2.sh package/base-files/files/sbin/brcmfmac43430-sdio-panther-x2.sh
chmod 755 package/base-files/files/sbin/brcmfmac43430-sdio-panther-x2.sh
