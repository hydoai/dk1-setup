#!/bin/bash

cd ~

read -p "If NVME drive is connected, format it so that there is one ext4 partition and 16GB of free space. Enter any key when done." NVME

git clone https://github.com/jetsonhacks/rootOnNVMe.git
cd rootOnNVMe
./copy-rootfs-ssd.sh
./setup-service.sh

read -p "Done setting NVME SSD as boot drive. Press any key to reboot. Then run 3-Jetson.sh" SSD

sudo reboot now
