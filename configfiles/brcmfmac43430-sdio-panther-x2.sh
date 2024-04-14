#!/bin/bash

# cd /lib/firmware/brcm/

wget -O /lib/firmware/brcm/brcmfmac43430-sdio.bin https://qsth520.gitee.io/files/wifi/brcmfmac43430-sdio.bin
wget -O /lib/firmware/brcm/brcmfmac43430-sdio.panther,x2.bin https://qsth520.gitee.io/files/wifi/brcmfmac43430-sdio.bin
wget -O /lib/firmware/brcm/brcmfmac43430-sdio.clm_blob https://qsth520.gitee.io/files/wifi/brcmfmac43430-sdio.clm_blob
wget -O /lib/firmware/brcm/brcmfmac43430-sdio.panther,x2.clm_blob https://qsth520.gitee.io/files/wifi/brcmfmac43430-sdio.clm_blob
wget -O /lib/firmware/brcm/brcmfmac43430-sdio.txt https://qsth520.gitee.io/files/wifi/brcmfmac43430-sdio
wget -O /lib/firmware/brcm/brcmfmac43430-sdio.panther,x2.txt https://qsth520.gitee.io/files/wifi/brcmfmac43430-sdio

echo "WiFi驱动包已下载到指定目录完毕，正在重启系统中……"

reboot