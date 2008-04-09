#
#  The prepare target will download the kernel from kernel.org, untar, and make it ready to use puspus config file.
#

LINUX_KERNEL_VERSION=2.6.22.18
LINUX_KERNEL_DIRECTORY=linux-$(LINUX_KERNEL_VERSION)
LINUX_KERNEL_FILENAME=$(LINUX_KERNEL_DIRECTORY).tar.gz
LINUX_KERNEL_URL=http://kernel.org/pub/linux/kernel/v2.6/$(LINUX_KERNEL_FILENAME)

all: nope

prepare: linux
linux:

	@echo Downloading kernel ver: $(LINUX_KERNEL_VERSION) and preparing for compilation
	wget -c $(LINUX_KERNEL_URL)
	tar -zxf $(LINUX_KERNEL_FILENAME)
	ln -s $(LINUX_KERNEL_DIRECTORY) linux

	@echo patching and preparing Kernel configuration for Netvista 8363
	cp config-puspus-$(LINUX_KERNEL_VERSION) linux/.config
	patch -p0 < diff-puspus-$(LINUX_KERNEL_VERSION).patch
	@echo The Kernel sources are ready to build
