include common.mk

SNAPPY_IMAGE := ubuntu-core-nitrogen-`date +%Y%m%d`.img
DEFAULT_IMAGE := nitrogen.img
UBUNTU_CORE_CH := stable
UBUNTU_IMAGE=/snap/bin/ubuntu-image

all: build

clean:
	rm -f $(OUTPUT_DIR)/*.img.xz
distclean: clean

build-snappy:
	@echo "build snappy..."
	$(UBUNTU_IMAGE) \
		-c $(UBUNTU_CORE_CH) \
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
