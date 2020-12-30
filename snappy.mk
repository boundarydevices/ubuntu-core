include common.mk

DEFAULT_IMAGE := nitrogen.img
UBUNTU_CORE_CHANNEL ?= stable
UBUNTU_IMAGE := /snap/bin/ubuntu-image
SNAPPY_IMAGE := ubuntu-core18-armhf-nitrogen-$(UBUNTU_CORE_CHANNEL)-`date +%Y%m%d`.img

all: build

clean:
	rm -f $(OUTPUT_DIR)/*.img.xz
distclean: clean

build-snappy:
	@echo "build snappy..."
	$(UBUNTU_IMAGE) snap \
		-c $(UBUNTU_CORE_CHANNEL) \
		--image-size 1G \
		--snap $(GADGET_SNAP) \
		--snap $(KERNEL_SNAP) \
		-O $(OUTPUT_DIR) \
		$(IMAGE_MODEL)

pack: build-snappy
	mv $(DEFAULT_IMAGE) $(SNAPPY_IMAGE)
	gzip $(SNAPPY_IMAGE)

build: build-snappy pack

.PHONY: build-snappy pack build
