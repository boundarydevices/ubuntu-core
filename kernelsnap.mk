include common.mk

all: build

clean:
	rm -f nitrogen-kernel*.snap
	cd $(KERNEL_DIR); snapcraft clean

distclean: clean
	rm -rf $(KERNEL_SRC)
	rm -rf $(FIRMWARE_PATH)

build:
	cd $(KERNEL_DIR); snapcraft --target-arch armhf snap
	mv $(KERNEL_DIR)/$(KERNEL_SNAP) $(OUTPUT_DIR)

.PHONY: build
