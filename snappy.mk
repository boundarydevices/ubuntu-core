include common.mk

DEFAULT_IMAGE := nitrogen.img
UBUNTU_CORE_CHANNEL ?= stable
UBUNTU_IMAGE := /snap/bin/ubuntu-image
SNAPPY_IMAGE := ubuntu-core-nitrogen-$(UBUNTU_CORE_CHANNEL)-`date +%Y%m%d`.img

all: build

clean:
	rm -f $(OUTPUT_DIR)/*.img.xz
distclean: clean

build-snappy:
	@echo "build snappy..."
	$(UBUNTU_IMAGE) \
		-c $(UBUNTU_CORE_CHANNEL) \
		--image-size 1G \
		--extra-snaps $(GADGET_SNAP) \
		--extra-snaps $(KERNEL_SNAP) \
		--extra-snaps snapweb \
		-O $(OUTPUT_DIR) \
		$(IMAGE_MODEL)

pack: build-snappy
	mv $(DEFAULT_IMAGE) $(SNAPPY_IMAGE)
	gzip $(SNAPPY_IMAGE)

build: build-snappy pack

.PHONY: build-snappy pack build
