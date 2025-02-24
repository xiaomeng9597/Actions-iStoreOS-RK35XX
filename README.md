# iStore OS 固件 | 定制的麻烦自行 fork 修改

[![iStore使用文档](https://img.shields.io/badge/使用文档-iStore%20OS-brightgreen?style=flat-square)](https://doc.linkease.com/zh/guide/istoreos) [![最新固件下载](https://img.shields.io/github/v/release/xiaomeng9597/Actions-iStoreOS-RK35XX?style=flat-square&label=最新固件下载)](../../releases/latest)

![支持设备](https://img.shields.io/badge/支持设备:-blueviolet.svg?style=flat-square) ![H88K](https://img.shields.io/badge/H88K-blue.svg?style=flat-square) ![H66K](https://img.shields.io/badge/H66K-blue.svg?style=flat-square) ![H68K](https://img.shields.io/badge/H68K-blue.svg?style=flat-square) ![H69K](https://img.shields.io/badge/H69K-blue.svg?style=flat-square) ![R5S](https://img.shields.io/badge/R5S-blue.svg?style=flat-square) ![R6S](https://img.shields.io/badge/R6S-blue.svg?style=flat-square) ![R66S](https://img.shields.io/badge/R66S-blue.svg?style=flat-square) ![R68S](https://img.shields.io/badge/R68S-blue.svg?style=flat-square) ![STATION P2](https://img.shields.io/badge/STATION%20P2-blue.svg?style=flat-square) ![T68M](https://img.shields.io/badge/T68M-blue.svg?style=flat-square) ![JIANPIAN TVBOX](https://img.shields.io/badge/JIANPIAN%20TVBOX-blue.svg?style=flat-square) ![PANTHER X2](https://img.shields.io/badge/PANTHER%20X2-blue.svg?style=flat-square) ![DG NAS LITE](https://img.shields.io/badge/DG%20NAS%20LITE-blue.svg?style=flat-square) ![IDO3568 CM4](https://img.shields.io/badge/IDO3568%20CM4-blue.svg?style=flat-square) ![EZPRO Mrkaio M68S](https://img.shields.io/badge/EZPRO%20Mrkaio%20M68S-blue.svg?style=flat-square) ![EZPRO Mrkaio M68S PLUS](https://img.shields.io/badge/EZPRO%20Mrkaio%20M68S%20PLUS-blue.svg?style=flat-square) ![DG TN3568](https://img.shields.io/badge/DG%20TN3568-blue.svg?style=flat-square) ![YIJIAHE JM10](https://img.shields.io/badge/YIJIAHE%20JM10-blue.svg?style=flat-square)

## 默认配置

- IP: `http://192.168.100.1` or `http://iStoreOS.lan/`
- 用户名: `root`
- 密码: `password`
- 如果设备只有一个网口，则此网口就是 `LAN` , 如果大于一个网口, 默认第一个网口是 `WAN` 口, 其它都是 `LAN`
- 如果要修改 `LAN` 口 `IP` , 首页有个内网设置，或者用命令 `quickstart` 修改
- 北京时间每天 `0:00` 定时编译, `Release` 中只保留不同架构的最新版本
- 历史版本在 `Actions` 中选择一个已经运行完成且成功的 `workflow` 在页面底部可以看到 `Artifacts`, `Artifacts` 需要登录 Github 才能下载
- 请把要加入的插件配置项填写在仓库 “configfiles/config_data.txt” 文件里面，假如你直接填写到 “rk35xx/.config” 文件里面绝对会丢你新加的配置项，因为每天会定时执行同步文件工作流会自动更新.config为istoreos官方最新的配置文件。
- 自行定制时需要注意这几点：假如你禁用了 “Sync Files” 工作流的话，那插件配置项就要填写到 “rk35xx/.config” 文件里面才行，反之你没禁用 “Sync Files” 工作流的话，那插件配置项就要填写到 “configfiles/config_data.txt” 文件里面才行。
- 使用此仓库必须设置机密token，Actions云编译固件时需要用到，其他人无法看到的（通常在仓库设置里面，严禁在仓库可视代码中填写，否则后果自负），机密键名为 `ACCESS_TOKEN`

## 支持架构

### RK33xx 架构

| 设备       | 包名称                                                                    |
| ---------- | ------------------------------------------------------------------------- |
| R2S        | istoreos-rockchip-armv8-friendlyarm_nanopi-r2s-squashfs-sysupgrade.img.gz |
| R4S        | istoreos-rockchip-armv8-friendlyarm_nanopi-r4s-squashfs-sysupgrade.img.gz |
| R4SE       | istoreos-rockchip-armv8-friendlyarm_nanopi-r4se-squashfs-sysupgrade.img.gz |
| ROCK-PI-4A | istoreos-rockchip-armv8-radxa_rock-pi-squashfs-sysupgrade.img.gz  |
| ROCKPRO64  | istoreos-rockchip-armv8-pine64_rockpro64-squashfs-sysupgrade.img.gz  |

### RK35xx 架构

| 设备           | 包名称                                                                   |
| -------------- | ------------------------------------------------------------------------ |
| H66K/H68K/H69K | istoreos-rockchip-rk35xx-hinlink_opc-h6xk-squashfs-combined.img.gz       |
| H88K           | istoreos-rockchip-rk35xx-hinlink_h88k-squashfs-combined.img.gz           |
| NANOPI-R5S     | istoreos-rockchip-rk35xx-friendlyarm_nanopi-r5s-squashfs-combined.img.gz |
| NANOPI-R6S     | istoreos-rockchip-rk35xx-friendlyarm_nanopi-r6s-squashfs-combined.img.gz |
| R66S/R68S      | istoreos-rockchip-rk35xx-fastrhino_r6xs-squashfs-combined.img.gz         |
| STATION-P2     | istoreos-rockchip-rk35xx-firefly_station-p2-squashfs-combined.img.gz     |
| T68M     | istoreos-rockchip-rk35xx-lyt_t68m-squashfs-combined.img.gz     |
| JIANPIAN-TVBOX     | istoreos-rockchip-rk35xx-jp_tvbox-squashfs-sysupgrade.img.gz     |
| PANTHER-X2     | istoreos-rockchip-rk35xx-panther_x2-squashfs-sysupgrade.img.gz     |
| DG-NAS-LITE/IDO3568-CM4 | istoreos-rockchip-rk35xx-dg_nas-lite-squashfs-sysupgrade.img.gz     |
| EZPRO-Mrkaio-M68S     | istoreos-rockchip-rk35xx-ezpro_mrkaio-m68s-squashfs-sysupgrade.img.gz     |
| EZPRO-Mrkaio-M68S-PLUS     | istoreos-rockchip-rk35xx-ezpro_mrkaio-m68s-plus-squashfs-sysupgrade.img.gz     |
| DG-TN3568     | istoreos-rockchip-rk35xx-dg_tn3568-squashfs-sysupgrade.img.gz     |
| YIJIAHE-JM10     | istoreos-rockchip-rk35xx-yijiahe_jm10-squashfs-sysupgrade.img.gz     |

### x86 架构

| 启动       | 包名称                                              |
| ---------- | --------------------------------------------------- |
| X86-64     | istoreos-x86-64-generic-squashfs-combined.img.gz    |
| X86-64-EFI | storeos-x86-64-generic-squashfs-combined-efi.img.gz |

## 鸣谢

- [istoreos](https://github.com/istoreos/istoreos)
- [P3TERX/Actions-OpenWrt](https://github.com/P3TERX/Actions-OpenWrt)
- [Microsoft Azure](https://azure.microsoft.com)
- [GitHub Actions](https://github.com/features/actions)
- [OpenWrt](https://github.com/openwrt/openwrt)
- [Lean&#39;s OpenWrt](https://github.com/coolsnowwolf/lede)
- [tmate](https://github.com/tmate-io/tmate)
- [mxschmitt/action-tmate](https://github.com/mxschmitt/action-tmate)
- [csexton/debugger-action](https://github.com/csexton/debugger-action)
- [Cowtransfer](https://cowtransfer.com)
- [WeTransfer](https://wetransfer.com/)
- [Mikubill/transfer](https://github.com/Mikubill/transfer)
- [softprops/action-gh-release](https://github.com/softprops/action-gh-release)
- [ActionsRML/delete-workflow-runs](https://github.com/ActionsRML/delete-workflow-runs)
- [dev-drprasad/delete-older-releases](https://github.com/dev-drprasad/delete-older-releases)
- [peter-evans/repository-dispatch](https://github.com/peter-evans/repository-dispatch)
- [draco-china/istoreos-actions](https://github.com/draco-china/istoreos-actions)

## 捐赠
- 如果你觉得此系统好用的话，请我喝一杯82年的凉白开吧，感谢！

-支付宝-
# <img src="https://jihulab.com/xiaomeng9597/webfiles/-/raw/main/zfb.jpg?inline=true" alt="支付宝收款码" width="200" />

-微信-
# <img src="https://jihulab.com/xiaomeng9597/webfiles/-/raw/main/weixin.jpg?inline=true" alt="微信收款码" width="200" />
