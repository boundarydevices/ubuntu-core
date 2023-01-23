# Snappy Ubuntu Core

This repository contains every needed to build your own Snappy Ubuntu Core OS image for **Boundary Devices Nitrogen** platforms.

## Build requirements

First of all, it is highly recommended to build from **Ubuntu 20.04** or later. Although there are solutions for different OS flavours, some tools are limited to Ubuntu for now.

Then you need to install the following packages in order to build Ubuntu Core.
```
~$ sudo apt update
~$ sudo apt install -y build-essential u-boot-tools snapd \
   gcc-arm-linux-gnueabihf gcc-aarch64-linux-gnu
~$ sudo snap install snapcraft --classic
~$ sudo snap install ubuntu-image --classic
```

You can check that the `snap` is working on your host machine by listing the available packages:
```
~$ snap list
Name               Version                     Rev    Tracking       Publisher   Notes
core               16-2.58                     14447  latest/stable  canonical✓  core
core18             20221212                    2667   latest/stable  canonical✓  base
core20             20221212                    1778   latest/stable  canonical✓  base
snapcraft          6.1                         7201   6.x/stable     canonical✓  classic
ubuntu-image       2.2+snap10                  321    latest/stable  canonical✓  classic
```

## Build procedure

### Getting the source code

Simply clone this repository:
```
~$ git clone https://github.com/boundarydevices/ubuntu-core.git
~$ cd ubuntu-core
```

### Gadget build

If you just wish to build the `gadget`:
```
~/ubuntu-core$ make gadget
```

### Kernel build

If you don't build from a Focal 20.04 OS, we recommend using LXD:
```
~$ sudo snap install lxd
~$ sudo lxd init --auto
~$ sudo lxc launch ubuntu:20.04 focal
~$ sudo lxc shell focal
```
Then you can simply build the `kernelsnap`:
```
~/ubuntu-core$ make kernelsnap
```

### Image generation

If you re-built the `kernel` or the `gadget` manually, you can simply generate the image:
```
~/ubuntu-core$ make snappy
```

## Flashing instructions

The output file should be named `ubuntu-coreXX-<arch>-nitrogen-yyyymmdd.img.gz`.

You can then simply flash it using `zcat` and `dd`.

```
~/ubuntu-core$ zcat ubuntu-core*.img.gz | sudo dd of=/dev/sdX bs=1M oflag=sync
```
