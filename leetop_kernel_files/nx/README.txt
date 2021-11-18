

1.Unzip file 
2.copy the file to Image Download  by sdkmanagers (Linux_for_tegra) to same directory
3.put target into recovery mode
4.update dtb 
  sudo ./flash.sh -r -k kernel-dtb  jetson-xavier-nx-devkit-emmc mmcblk0p1
   

all flash cmd
 sudo ./flash.sh -r jetson-xavier-nx-devkit-emmc mmcblk0p1
 
 NOte:
   Need to download jetpack by sdkmangers first or from nvidia download centers(https://developer.nvidia.com/embedded/downloads)
