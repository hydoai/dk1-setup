#!/bin/bash
cd ~
sudo apt update
sudo apt -y upgrade
sudo apt install -y nvidia-jetpack
sudo apt install -y python3-pip
sudo -H pip3 install -U jetson-stats
