OUTPUT_DIR := $(PWD)
IMAGE_MODEL := $(OUTPUT_DIR)/model/nitrogen.model
GADGET_DIR := $(OUTPUT_DIR)/gadget
GADGET_VERSION := `grep version $(GADGET_DIR)/meta/snap.yaml | awk '{print $$2}'`
GADGET_SNAP := nitrogen-gadget_$(GADGET_VERSION)_armhf.snap
KERNEL_DIR := $(OUTPUT_DIR)/kernel
KERNEL_VERSION := `cat $(KERNEL_DIR)/snapcraft.yaml | grep version: | awk '{print $$2}'`
KERNEL_SNAP := nitrogen-kernel_$(KERNEL_VERSION)_armhf.snap
