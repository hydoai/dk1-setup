# Ground-up Setup Instructions for HYDO Devkit-One

This guide contains two parts. 

**Part 1**: Installing the operating system and changing boot drive. This part is different for Jetson Nano and Jetson Xavier NX.

**Part 2**: Installing packages. This part is identical for both Nano and Xavier NX. We provide a pre-made disk image for both Nano and Xavier NX, but this guide will also cover the full command line installation too.

## Before you begin

**This guide is intended for the below hardware configuration:**

+ [NVIDIA Jetson Nano 4GB module](https://www.nvidia.com/en-us/autonomous-machines/embedded-systems/jetson-nano/)
+ or, [NVIDIA Jetson Xavier NX module](https://www.nvidia.com/en-us/autonomous-machines/embedded-systems/jetson-xavier-nx/)
+ [Leetop A203 carrier board](http://www.leetop.top/leetopen.asp?id=256)
+ [128GB 2242 NVMe SSD (link is example only)](https://www.transcend-info.com/Embedded/Products/No-1164) Any capacity at or above 32GB is acceptable..

**and for the below software versions:**

+ [NVIDIA JetPack 4.6](https://developer.nvidia.com/jetpack-sdk-46), which includes [(L4T 32.6.1)](https://developer.nvidia.com/embedded/linux-tegra-r3261)

## Part 1: OS & Boot Drive

### Jetson Nano-based

<details><summary>Click to explanation for the script.</summary>
<p>

#### Download L4T Driver Package and Sample Root Filesystem from NVIDIA

+ [Link to download L4T Driver Package for Nano](https://developer.nvidia.com/embedded/l4t/r32_release_v6.1/t210/jetson-210_linux_r32.6.1_aarch64.tbz2) ([storage.hydo.ai mirror](http://storage.hydo.ai/nvidia-mirror/jetpack4-6/nano/Jetson-210_Linux_R32.6.1_aarch64.tbz2))
+ [Link to download Sample Root Filesystem for Nano](https://developer.nvidia.com/embedded/l4t/r32_release_v6.1/t210/tegra_linux_sample-root-filesystem_r32.6.1_aarch64.tbz2)

Using Leetop A203 carrier board requires adding a kernel dtb (device tree binary) file to the L4T driver.

#TODO! get this file from leetop
+ [A203 nano kernel]()

</p></details>

### Jetson Xavier NX-based

On your notebook or desktop, **clone this repository**:
```
git clone https://github.com/hydoai/dk1-setup.git
```

**Navigate to `flashing\_scripts/nx`**:
```
cd flashing_scripts/nx
```

**Run [1-host.sh](flashing_scripts/nx/1-host.sh) and follow directions**:
```
./1-host.sh
```

<details><summary>Click to explanation for the script.</summary>
<p>

+ [Download L4T Driver Package for NX](https://developer.nvidia.com/embedded/l4t/r32_release_v6.1/t186/jetson_linux_r32.6.1_aarch64.tbz2)
+ [Download Sample Root Filesystem for NX](https://developer.nvidia.com/embedded/l4t/r32_release_v6.1/t186/tegra_linux_sample-root-filesystem_r32.6.1_aarch64.tbz2)

Decompress L4T Driver Package:

```bash
tar -xvf Jetson_Linux_R32.6.1_aarch64.tbz2
```

This will output a directory named `Linux_for_Tegra`. 

Inside this, we will add a new kernel dtb file from Leetop for the A203 carrier board.

+ [Download A203 Jetpack4.6 dtb](leetop_kernel_files/jetpack4.6_203nx.rar)

Decompress the downloaded `.rar` file:

```bash
sudo apt install unrar
unrar x jetpack4.6_203nx.rar
```

This will extract one `.dtb` file insde `nx/Linux_for_Tegra/kernel/dtb` directory.

Copy this to the same corresponding directory in the full `Linux for Tegra` directory extracted above, and compress it back with tar.

</p>
</details>

On your Jetson, **clone this repository**:
```bash
git clone https://github.com/hydoai/dk1-setup.git
```

Navigate to `nvme_boot_script`:
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

([See setup guide for storage server](https://github.com/hydoai/fs1-setup))

**Download Disk Image**:

+ [**for Xavier NX**](http://storage.hydo.ai/nx-img-latest.img)(SIZE WARNING 109GB)
+ [**for Nano**](http://storage.hydo.ai/nano-img-latest.img)(SIZE WARNING 30GB)

**Connect NVMe drive to computer.**

**Delete all partitions**

**Create one ext4 partition of size 30GB** 

Match partition size to disk image size.

**Recover partition with downloaded disk image**

**Install NVMe drive onto Jetson carrier board**

**Resize partition to fill disk (or however large you want it)**


### Install everything from the command line

*This way is NOT recommended. This entire process may take up to 10 hours*


