include common.mk

DEFAULT_IMAGE := nitrogen.img
UBUNTU_CORE_CHANNEL ?= stable
UBUNTU_IMAGE := /snap/bin/ubuntu-image
SNAPPY_IMAGE := ubuntu-core20-arm64-nitrogen-$(UBUNTU_CORE_CHANNEL)-`date +%Y%m%d`.img

all: build

clean:
	rm -f $(OUTPUT_DIR)/*.img.gz
distclean: clean

build-snappy:
	@echo "build snappy..."
	$(UBUNTU_IMAGE) snap \
		-O $(OUTPUT_DIR) \
		$(IMAGE_MODEL)

pack: build-snappy
	mv $(DEFAULT_IMAGE) $(SNAPPY_IMAGE)
	gzip $(SNAPPY_IMAGE)

build: build-snappy pack

.PHONY: build-snappy pack build
