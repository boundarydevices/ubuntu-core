# U-Boot is flashed in NOR on Nitrogen platforms, so having a bootloader image
# doesn't make sense.
# Also, we want this image to work on all Nitrogen platforms so specifying only
# one bootloader isn't possible.
# So we create a stub environment but use our regular bootscript to do all
# the magic when booting.

include common.mk

all: build

clean:
	rm -rf $(GADGET_DIR)/boot-assets
	rm -f $(GADGET_DIR)/uboot.conf
	rm -f $(GADGET_DIR)/uboot.env
	rm -f $(OUTPUT_DIR)/nitrogen-gadget_*

distclean: clean

u-boot:
	@if [ ! -d $(GADGET_DIR)/boot-assets ] ; then mkdir $(GADGET_DIR)/boot-assets; fi
	mkimage -A arm -O linux -T script -C none -a 0 -e 0 -n "boot script" -d $(GADGET_DIR)/bootscript.txt $(GADGET_DIR)/boot-assets/boot.scr

preload: u-boot
	touch $(GADGET_DIR)/uboot.conf

snappy: preload
	snapcraft --target-arch armhf snap gadget

build: u-boot preload snappy

.PHONY: u-boot snappy gadget build preload
