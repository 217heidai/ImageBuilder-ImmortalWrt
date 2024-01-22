#!/bin/bash

echo "Start Builder Patch !"
echo "Current Path: $PWD"

cd $GITHUB_WORKSPACE/$VENDOR-imagebuilder-$VERSION-x86-64.Linux-x86_64 || exit

# Remove redundant default packages
sed -i "/luci-app-cpufreq/d" include/target.mk


# Force opkg to overwrite files
# sed -i "s/install \$(BUILD_PACKAGES)/install \$(BUILD_PACKAGES) --force-overwrite/" Makefile


# 移除不需要的包
# 关闭 ipv6
sed -i "s/CONFIG_IPV6=y/CONFIG_IPV6=n/" .config

# 关闭 dhcp
sed -i "s/CONFIG_PACKAGE_dnsmasq_full_dhcp=y/# CONFIG_PACKAGE_dnsmasq_full_dhcp is not set/" .config
sed -i "s/CONFIG_PACKAGE_dnsmasq_full_dhcpv6=y/# CONFIG_PACKAGE_dnsmasq_full_dhcpv6 is not set/" .config

# 不生成 EXT4 硬盘格式镜像
sed -i "s/CONFIG_TARGET_ROOTFS_EXT4FS=y/# CONFIG_TARGET_ROOTFS_EXT4FS is not set/" .config
# 不生成非 EFI 镜像
sed -i "s/CONFIG_GRUB_IMAGES=y/# CONFIG_GRUB_IMAGES is not set/" .config
# 不生成 ISO
sed -i "s/CONFIG_ISO_IMAGES=y/# CONFIG_ISO_IMAGES is not set/" .config
# 不生成 VHDX
sed -i "s/CONFIG_VHDX_IMAGES=y/# CONFIG_VHDX_IMAGES is not set/" .config
# 不生成 VDI
sed -i "s/CONFIG_VDI_IMAGES=y/# CONFIG_VDI_IMAGES is not set/" .config
# 不生成 VMDK
sed -i "s/CONFIG_VMDK_IMAGES=y/# CONFIG_VMDK_IMAGES is not set/" .config
# 不生成 QCOW2
sed -i "s/CONFIG_QCOW2_IMAGES=y/# CONFIG_QCOW2_IMAGES is not set/" .config

# 修改分区大小
sed -i "s/CONFIG_TARGET_KERNEL_PARTSIZE=32/CONFIG_TARGET_KERNEL_PARTSIZE=64/" .config
sed -i "s/CONFIG_TARGET_ROOTFS_PARTSIZE=300/CONFIG_TARGET_ROOTFS_PARTSIZE=1024/" .config

