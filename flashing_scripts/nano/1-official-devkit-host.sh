#!/bin/bash

# Version Information
# L4T_RELEASE: R32.6.1 (Jetpack 4.6)
# Jetson Module: Xavier NX 8GB RAM, 16GB eMMC

# fix failed flashing t186ref issue
sudo apt install python-is-python3
export LANG=en_US.UTF-8
source ~/.bashrc

read -p "Download new L4T Driver and Sample Root Filesystem?[Y/n]" NEW_DOWNLOAD

 case $NEW_DOWNLOAD in
     [Yy]* )
         mkdir downloads
         rm -r downloads/*
         # Download 32.6.1 driver package
         wget -P downloads https://developer.nvidia.com/embedded/l4t/r32_release_v6.1/t210/jetson-210_linux_r32.6.1_aarch64.tbz2
         # Download sample root filesystem
         wget -P downloads https://developer.nvidia.com/embedded/l4t/r32_release_v6.1/t210/tegra_linux_sample-root-filesystem_r32.6.1_aarch64.tbz2
         ;;
    [Nn]* )
        echo "Continuing without downloading new versions."
        ;;
esac

sudo apt install -y qemu-user-static libxml2-utils

export L4T_RELEASE_PACKAGE='jetson-210_linux_r32.6.1_aarch64.tbz2'
export SAMPLE_FS_PACKAGE='tegra_linux_sample-root-filesystem_r32.6.1_aarch64.tbz2'
# Get BOARD name from:
#https://docs.nvidia.com/jetson/l4t/index.html#page/Tegra%20Linux%20Driver%20Package%20Development%20Guide/quick_start.html#wwpID0E0JD0HA
export BOARD='jetson-nano-devkit-emmc'

cd downloads

sudo tar -xvf $L4T_RELEASE_PACKAGE
# Copying custom kernel dtb file for a203
#cp ../../../leetop_kernel_files/a203-nano/Linux_for_Tegra/kernel/dtb/tegra210-p3448-0002-p3449-0000-b00.dtb Linux_for_Tegra/kernel/dtb
cd Linux_for_Tegra/rootfs
sudo tar -xvpf ../../$SAMPLE_FS_PACKAGE
cd ..

sudo ./apply_binaries.sh

echo
echo
echo "NEXT STEPS:"
echo "1. Connect your Jetson micro USB to the host computer."
echo "2. Short the RECO pin on the carrier board."
echo "3. Plug in DC power to the board."
echo
read -p "Press any key when ready" READY

sudo ./flash.sh ${BOARD} mmcblk0p1

echo
echo
echo "NEXT STEPS:"
echo "1. Short the RESET pins on Jetson. This will reboot the board."
echo "2. Connect keyboard, mouse, and display"
echo "3. Create Ubuntu account on Jetson"
echo
read -p "Press any key to exit" DONE

