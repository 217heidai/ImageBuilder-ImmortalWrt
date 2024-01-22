#!/bin/bash

# 打印 info
make info

# 指定要构建的目标映像
PROFILE="generic"

# 要嵌入映像的软件包列表
PACKAGES=""
# 基础包
## 基础组件
PACKAGES="$PACKAGES bash coremark curl e2fsprogs kmod-iavf kmod-ipt-nat kmod-ipt-nat6 kmod-lib-zstd kmod-tcp-bbr lm-sensors-detect nano wget-ssl zram-swap"
## 主题
PACKAGES="$PACKAGES luci-theme-argon luci-i18n-argon-config-zh-cn"
## 界面翻译补全
PACKAGES="$PACKAGES luci-i18n-opkg-zh-cn luci-i18n-base-zh-cn luci-i18n-firewall-zh-cn"

# 系统
## 定时重启
PACKAGES="$PACKAGES luci-i18n-autoreboot-zh-cn"
## 高级设置
PACKAGES="$PACKAGES luci-i18n-advancedsetting-zh-cn"

# 服务
## passwall
PACKAGES="$PACKAGES luci-i18n-passwall-zh-cn"
## upnp
PACKAGES="$PACKAGES luci-i18n-upnp-zh-cn"


# 移除不需要的包
## 基础包
PACKAGES="$PACKAGES -alsa-utils -automount -kmod-fs-f2fs"
## 音频驱动
PACKAGES="$PACKAGES -kmod-sound-hda-codec-hdmi -kmod-sound-hda-codec-realtek -kmod-sound-hda-codec-via -kmod-sound-hda-core -kmod-sound-hda-intel -kmod-sound-i8x0 -kmod-sound-via82xx"
## USB驱动
PACKAGES="$PACKAGES -kmod-usb-audio -kmod-usb-net -kmod-usb-net-asix -kmod-usb-net-asix-ax88179 -kmod-usb-net-rtl8150 -kmod-usb-net-rtl8152-vendor"
## remove pppoe
PACKAGES="$PACKAGES -ppp -ppp-mod-pppoe"
## remove IPv6，CONFIG_IPV6=n
PACKAGES="$PACKAGES -ip6tables -odhcp6c -kmod-ipv6 -kmod-ip6tables -odhcpd-ipv6only -ipv6helper"
## remove dhcp server
PACKAGES="$PACKAGES -odhcpd"

# 包含自定义文件的目录
FILES="files"

# 要禁用的 /etc/init.d 中服务的名称
DISABLED_SERVICES="sshd"

make image PROFILE="$PROFILE" PACKAGES="$PACKAGES" FILES="$FILES" DISABLED_SERVICES="$DISABLED_SERVICES"
