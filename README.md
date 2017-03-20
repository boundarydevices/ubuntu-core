# Snappy Ubuntu Core

This repository contains every needed to build your own Snappy Ubuntu Core OS image for **Boundary Devices Nitrogen** platforms.

## Build requirements

First of all, it is highly recommended to build from **Ubuntu 16.04** or later. Although there are solutions for different OS flavours, some tools are limited to Ubuntu for now.

Then you need to install the following packages in order to build Ubuntu Core.
```
~$ sudo apt update
~$ sudo apt install -y build-essential u-boot-tools lzop gcc-arm-linux-gnueabihf
~$ sudo apt install -y snap snapcraft
~$ sudo snap install ubuntu-image --devmode --edge
```

You can check that the `snap` is working on your host machine by listing the available packages:
```
~$ snap list
Name          Version     Rev   Developer  Notes
core          16-2        1337  canonical  -
ubuntu-image  0.15+snap3  48    canonical  devmode
```

**NOTE**: make sure that you have the latest `snapcraft` tool available, using versions < 2.27.1 have proven to be troublesome.

## Build procedure

### Getting the source code

Simply clone this repository:
```
~$ git clone https://github.com/boundarydevices/ubuntu-core.git
~$ cd ubuntu-core
```

### Full build

In order to build the whole OS image, you just need to issue the following:
```
~/ubuntu-core$ make
```

The output file should be named `ubuntu-core-nitrogen-yyyymmdd.img.gz`.

You can then simply flash it using `zcat` and `dd`.

```
~/ubuntu-core$ zcat ubuntu-core-nitrogen-xxxx.img.gz | sudo dd of=/dev/sdX bs=1M
```

### Gadget build

If you just wish to build the `gadget`:
```
~/ubuntu-core$ make gadget
```

### Kernel build

If you just wish to build the `kernel`:
```
~/ubuntu-core$ make kernel
```

### Image generation

If you re-built the `kernel` or the `gadget` manually, you can simply generate the image:
```
~/ubuntu-core$ make snappy
```
