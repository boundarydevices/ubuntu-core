include common.mk

KERNEL_SRC := $(KERNEL_DIR)/linux-imx6
KERNEL_BRANCH := boundary-imx_5.4.x_2.2.0
KERNEL_COMMIT := `git ls-remote https://github.com/boundarydevices/linux-imx6.git $(KERNEL_BRANCH) | awk '{print $$1}'`
KERNEL_ARCHIVE := https://github.com/boundarydevices/linux-imx6/archive/$(KERNEL_COMMIT).tar.gz

QCACLD_SRC := $(KERNEL_SRC)/drivers/staging/qcacld-2.0
QCACLD_BRANCH := boundary-LNX.LEH.4.2.2.2
QCACLD_COMMIT := `git ls-remote https://github.com/boundarydevices/qcacld-2.0.git $(QCACLD_BRANCH) | awk '{print $$1}'`
QCACLD_ARCHIVE := https://github.com/boundarydevices/qcacld-2.0/archive/$(QCACLD_COMMIT).tar.gz

FIRMWARE_PATH := $(KERNEL_DIR)/firmware
FIRMWARE_URL := http://linode.boundarydevices.com/snappy/firmware.tar

all: build

clean:
	rm -f nitrogen-kernel*.snap
	cd $(KERNEL_DIR); snapcraft clean
	rm -rf $(KERNEL_SRC)
	rm -rf $(FIRMWARE_PATH)

distclean: clean
	rm -rf $(KERNEL_SRC)
	rm -rf $(FIRMWARE_PATH)

build: kernel_src qcacld_src firmware
	unset ARCH CROSS_COMPILE
	cd $(KERNEL_DIR); snapcraft --target-arch armhf snap
	mv $(KERNEL_DIR)/$(KERNEL_SNAP) $(OUTPUT_DIR)

kernel_src:
	if [ ! -f $(KERNEL_SRC)/Makefile ] ; then \
		curl -L $(KERNEL_ARCHIVE) | tar xz && \
		mv linux-imx6-* $(KERNEL_SRC) ; \
	fi

qcacld_src:
	if [ ! -f $(QCACLD_SRC)/Makefile ] ; then \
		curl -L $(QCACLD_ARCHIVE) | tar xz && \
		mv qcacld-2.0-* $(QCACLD_SRC) && \
		echo 'source "drivers/staging/qcacld-2.0/Kconfig"' >>  $(KERNEL_SRC)/drivers/staging/Kconfig && \
		echo 'obj-$$(CONFIG_QCA_CLD_WLAN)	+= qcacld-2.0/' >> $(KERNEL_SRC)/drivers/staging/Makefile ; \
	fi

firmware:
	if [ ! -d $(FIRMWARE_PATH) ] ; then \
		mkdir -p $(FIRMWARE_PATH) ; \
		curl $(FIRMWARE_URL) | tar xv -C $(FIRMWARE_PATH) ; \
	fi

.PHONY: build
