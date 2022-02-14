WORK IN PROGRESS

TODO

- [x] Get nano jetpack 4.6 dtb files
- [x] Create 30GB version of xavier disk image
- [ ] Re-create corrected 30GB disk images for nano and xavier (with the last few package scripts included)
- [ ] Insert screenshots for Part 2 
---

# Ground-up Setup Instructions for HYDO Devkit-One

This guide contains two parts. 

**Part 1**: Installing the operating system and changing boot drive. The process for Jetson Nano and Jetson Xavier NX are the same except for the files.

**Part 2**: Installing packages. This part is identical for both Nano and Xavier NX. We provide a pre-made disk image for both Nano and Xavier NX, but this guide will also cover the full command line installation.

## Before you begin

### Things you need

+ Normal desktop or laptop with Ubuntu 20.04 or similar (Pop_OS! 20.04) (other releases not tested, but most recent versions probably works)
+ USB-A to micro USB cable
+ [NVIDIA Jetson Nano 4GB module (with eMMC, NOT developer kit)](https://www.nvidia.com/en-us/autonomous-machines/embedded-systems/jetson-nano/)
+ or, [NVIDIA Jetson Xavier NX module (with eMMC, NOT developer kit)](https://www.nvidia.com/en-us/autonomous-machines/embedded-systems/jetson-xavier-nx/)
+ [Leetop A203 carrier board](http://www.leetop.top/leetopen.asp?id=256)
+ [128GB 2242 NVMe SSD (link is example only)](https://www.transcend-info.com/Embedded/Products/No-1164) Any capacity at or above 32GB is acceptable..

**This guide is intended for the below software versions:**

+ [NVIDIA JetPack 4.6](https://developer.nvidia.com/jetpack-sdk-46), which includes [L4T (Linux for Tegra) 32.6.1](https://developer.nvidia.com/embedded/linux-tegra-r3261)

## Part 1: OS & Boot Drive

### Jetson Nano-based

On your notebook or desktop, **clone this repository**:
```
git clone https://github.com/hydoai/dk1-setup.git
```

**Navigate to `flashing_scripts`**:
```
cd flashing_scripts
```

**Depending on your setup, run the right script:**

Compute Module Type | Carrier Board | Script name
---|---|---
Xavier NX eMMC | Leetop A203 | `nx/1-a203-host.sh`
Xavier NX eMMC | Developer kit | `nx/1-official-devkit-host.sh`
Nano eMMC | Leetop A203 | `nano/1-a203-host.sh`
Nano eMMC | Developer kit | `nano/1-emmc-devkit-host.sh`
Nano microSD | Developer kit | `nano/1-sdcard-devkit-host.sh`

<details><summary>Click to see explanations for the script.</summary>
<p>

Jetson modules either have a microSD card slot or internal memory (called eMMC).
If you buy a developer kit, the module will have a microSD card.
If you ordered a module separately, it probably has a eMMC.
  
The scripts for Leetop A203 automatically patch the official NVIDIA OS image with Leetop's proprietary Device Tree Binary (DTB) files, so that the USB ports on the Leetop A203 work as expected. They don't share those files publicly, so I had to email them for it.
  
#### Download L4T Driver Package and Sample Root Filesystem from NVIDIA

I have copied most large files to [storage.hydo.ai](https://storage.hydo.ai) as a mirror for faster downloads.

+ [Link to download L4T Driver Package for Nano](https://developer.nvidia.com/embedded/l4t/r32_release_v6.1/t210/jetson-210_linux_r32.6.1_aarch64.tbz2) ([storage.hydo.ai mirror](https://storage.hydo.ai/nvidia-mirror/jetpack4-6/nano/Jetson-210_Linux_R32.6.1_aarch64.tbz2))
+ [Link to download Sample Root Filesystem for Nano](https://developer.nvidia.com/embedded/l4t/r32_release_v6.1/t210/tegra_linux_sample-root-filesystem_r32.6.1_aarch64.tbz2) ([storage.hydo.ai mirror](https://storage.hydo.ai/nvidia-mirror/jetpack4-6/nano/Tegra_Linux_Sample-Root-Filesystem_R32.6.1_aarch64.tbz2))


Decompressing the L4T Driver Package will output a directory named `Linux_for_Tegra`. 

Inside this, we will add a new kernel dtb file from Leetop for the A203 carrier board.

+ [A203 Nano Jetpack4.6 dtb](leetop_kernel_files/jetpack_4.6_nano203.rar)

Decompress the `.rar` file while preserving directory:

This will extract one `.dtb` file insde `nx/Linux_for_Tegra/kernel/dtb` directory.

Copy this to the same corresponding directory in the full `Linux for Tegra` directory extracted above, and compress it back with tar.

Go straight to (#nvme-drive-boot)
  
#### Xavier files

Most of the steps are the same with Nano, but with these different files:

+ [Download L4T Driver Package for NX](https://developer.nvidia.com/embedded/l4t/r32_release_v6.1/t186/jetson_linux_r32.6.1_aarch64.tbz2) ([storage.hydo.ai mirror](https://storage.hydo.ai/nvidia-mirror/jetpack4-6/nx/Jetson_Linux_R32.6.1_aarch64.tbz2))
+ [Download Sample Root Filesystem for NX](https://developer.nvidia.com/embedded/l4t/r32_release_v6.1/t186/tegra_linux_sample-root-filesystem_r32.6.1_aarch64.tbz2) ([storage.hydo.ai mirror](https://storage.hydo.ai/nvidia-mirror/jetpack4-6/nx/Tegra_Linux_Sample-Root-Filesystem_R32.6.1_aarch64.tbz2))
+ [A203 Xavier NX Jetpack4.6 dtb](leetop_kernel_files/jetpack4.6_203nx.rar)

</p></details>

You might come across this message:

```
Configuration file '/etc/lightdm/lightdm.conf.d/50-nvidia.conf'
 ==> File on system created by you or by a script.
 ==> File also in package provided by package maintainer.
   What would you like to do about it ?  Your options are:
    Y or I  : install the package maintainer's version
    N or O  : keep your currently-installed version
      D     : show the differences between the versions
      Z     : start a shell to examine the situation
 The default action is to keep your current version.
*** 50-nvidia.conf (Y/I/N/O/D/Z) [default=N] ? y
```
Answer 'y'


### NVME Drive Boot

On your Jetson, **clone this repository**:
```bash
git clone https://github.com/hydoai/dk1-setup.git
```

**Navigate to `nvme_boot_script`:**
```bash
cd nvme_boot_script
```

**Run ./2-nvme-boot.sh**:
```bash
./2-nvme-boot.sh
```

Now, your Jetson boot disk will be set to the NVMe SSD.

You are ready to move to Part 2 of this guide.

## Part 2:

### Use pre-crafted disk image

*This is the recommended way to get your Devkit-One up and running. If you want fine-grained control over how and which packages are installed, please see the next section.*

([See setup guide for storage server (internal link)](https://github.com/hydoai/fs1-setup))

**Download Disk Image**:

+ [**for Xavier NX**](https://storage.hydo.ai/nx-latest.img) (30 GB)
+ [**for Nano**](https://storage.hydo.ai/nano-latest.img) (30GB)

**Connect NVMe drive to computer.**

**Delete all partitions**

**Create one ext4 partition of size 30GB** 

Match partition size to disk image size.

**Recover partition with downloaded disk image**

**Install NVMe drive onto Jetson carrier board**

**Resize partition to fill disk (or however large you want it)**


### Install everything from the command line

*This way is NOT recommended. This entire process may take up to 10 hours, because most packages need to recompiled from source.*

Basically, run every script in [package_scripts](package_scripts)


