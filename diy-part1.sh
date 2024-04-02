#!/bin/bash
#===============================================
# Description: DIY script
# File name: diy-script.sh
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#===============================================

# 修改版本为编译日期
date_version=$(date +"%Y%m%d%H")
# sed -i "s/0000000000/${date_version}/g" version

echo $date_version > version
