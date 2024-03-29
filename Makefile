#
# Makefile to build the pus-pus Debian system
# A GNU/Linux system for the IBM Netvista NS2200 - Model 8363
#

PUSPUS_VERSION=1
PUSPUS_SUBLEVEL=00

CURDIR ?= $(shell `pwd`)
CURTIMESTAMP= `date -R`
GRUB_STAGE2_TORITO=/usr/lib/grub/i386-pc/stage2_eltorito

KERNEL_PATH=$(CURDIR)/kernel/linux
VMLINUX_CONFIG=$(KERNEL_PATH)/.config
VMLINUX_IMAGE=$(KERNEL_PATH)/arch/i386/boot/compressed/vmlinux
VMLINUX_CONFIG_NETVISTA=kernel/config-puspus-2.6.22.18
VMLINUX_OUT=$(CURDIR)/boot
KERNEL2X00=$(VMLINUX_OUT)/kernel.2x00

ETCH=$(CURDIR)/etch
ETCHTAR=$(ETCH)/etch.tar

DEBOOTSTRAP=/usr/sbin/debootstrap
ROOTFS=rootfs
ROOTFS_CFILE=$(ROOTFS)/etc/pus-pus-release
ROOTFS_CFILE_TEMP=pus-pus-release.temp
INCLUDE_PKGS=dropbear,python,pciutils,usbutils,net-tools,wireless-tools,iptables,less,screen,perl,perl-modules,udev,ntpdate,initramfs-tools

CFLASH_DEV=/dev/YOUR_CFLASH_DEVICE
CFLASH_MOUNT=cflash
CFLASH_CFILE=boot/cflash-ready

PUSIMAGE=puspus-$(PUSPUS_VERSION).$(PUSPUS_SUBLEVEL)
PUSIMAGE_CFILE=boot/$(PUSIMAGE).img
PUSIMAGE_MD5SUM=boot/$(PUSIMAGE).md5

DEVLOOP=/dev/loop0

SUDO=sudo env PATH=/bin:/sbin:/usr/bin:/usr/sbin

#
# Placeholder rules for big jobs
#

.PHONY: prepare

puspus: all

all: prepare kernel rootfs

# build stage dependencies
kernel: prepare
rootfs: kernel

#
# Step 1 to 3 - Prepare the environment
#
prepare:
	$(MAKE) -C utils
	$(MAKE) -C kernel prepare
	$(MAKE) -C etch prepare INCLUDE_PKGS=$(INCLUDE_PKGS)

#
# Convenient rule to jump into customizing the kernel without too much effort
#
netvistaconfig:
	make -C kernel/linux menuconfig

#
# Step 4 - Compile the Linux Kernel
#
kernel: $(VMLINUX_IMAGE)
$(VMLINUX_IMAGE): $(VMLINUX_CONFIG)

	@echo Building the linux kernel for pus-pus
	$(MAKE) ARCH=i386 -C kernel/linux

	@echo Making pus-pus specific drivers
	$(MAKE) ARCH=i386 -C pusdrivers modules INSTALL_MOD_PATH=$(VMLINUX_OUT) KERNEL_PATH=$(KERNEL_PATH) LINUX_SRC=$(KERNEL_PATH)

	@echo Installing the kernel modules
	$(MAKE) ARCH=i386 -C kernel/linux INSTALL_MOD_PATH=$(VMLINUX_OUT) modules_install

	@echo Installing pus-pus specific drivers
	$(MAKE) ARCH=i386 -C pusdrivers install INSTALL_MOD_PATH=$(VMLINUX_OUT) KERNEL_PATH=$(KERNEL_PATH) LINUX_SRC=$(KERNEL_PATH)

	@echo Saving and Patching the kernel image
	cp $(VMLINUX_IMAGE) $(KERNEL2X00)
	utils/binpatch $(KERNEL2X00)

	@echo Kernel ready, you can call 'make rootfs' now


#
# Step 5 and 6 - Make a root file system based on Debian etch and configure the installation
#
rootfs: $(ROOTFS_CFILE)
$(ROOTFS_CFILE): $(KERNEL2X00) $(ETCHTAR)

	@echo "Building the puspus root filesystem version $(PUSPUS_VERSION).$(PUSPUS_SUBLEVEL)"
	$(SUDO) rm -rf $(ROOTFS)/*
	$(SUDO) $(DEBOOTSTRAP) --arch i386 --verbose --unpack-tarball $(ETCHTAR) --include=$(INCLUDE_PKGS) etch $(ROOTFS)

	@echo Customizing some basic system settings
	echo puspus > hostname.temp
	$(SUDO) cp hostname.temp $(ROOTFS)/etc/hostname
	rm hostname.temp

	@echo "10.1.1.10 puspus" > hosts.temp
	$(SUDO) cp hosts.temp $(ROOTFS)/etc/hosts
	rm hosts.temp

	@echo "proc            /proc           proc    defaults        0       0" >> fstab.temp
	$(SUDO) cp fstab.temp $(ROOTFS)/etc/fstab
	rm fstab.temp

	echo "auto lo" > interfaces.temp
	echo "iface lo inet loopback" >> interfaces.temp
	echo "address 127.0.0.1" >> interfaces.temp
	echo "netmask 255.0.0.0" >> interfaces.temp

	echo "auto eth2" >> interfaces.temp
	echo "iface eth2 inet static" >> interfaces.temp
	echo "address 10.1.1.10" >> interfaces.temp
	echo "netmask 255.255.255.0" >> interfaces.temp
	$(SUDO) cp interfaces.temp $(ROOTFS)/etc/network/interfaces
	rm interfaces.temp

	@echo Creating user accounts
	$(SUDO) chroot $(ROOTFS) useradd -m netvista
	$(SUDO) chroot $(ROOTFS) usermod --password `openssl passwd puspus` netvista
	$(SUDO) chroot $(ROOTFS) usermod --password `openssl passwd toor` root

	@echo Copying the kernel image and the kernel modules
	$(SUDO) cp $(KERNEL2X00) $(ROOTFS)
	$(SUDO) cp -Ra boot/lib/* $(ROOTFS)/lib/

	@echo Copying and installing extra packages
	$(SUDO) chroot $(ROOTFS) mkdir /root/debian-extra
	-$(SUDO) cp -Rv $(ETCH)/extra/*deb $(ROOTFS)/root/debian-extra
	-$(SUDO) chroot $(ROOTFS) dpkg -i --recursive root/debian-extra

	@echo Creating version control file
	echo "Pus-Pus Release $(PUSPUS_VERSION).$(PUSPUS_SUBLEVEL)" > $(ROOTFS_CFILE_TEMP)
	echo "Built on $(CURTIMESTAMP)" >> $(ROOTFS_CFILE_TEMP)
	$(SUDO) cp $(ROOTFS_CFILE_TEMP) $(ROOTFS_CFILE)
	$(SUDO) touch $(ROOTFS_CFILE)
	rm $(ROOTFS_CFILE_TEMP)
	@echo root file system created - you can now make cflash and/or pusiso!

#
# Custom step : Copy the kernel image and kernel modules into the compact flash
#
kernel-cflash:

	@echo Mounting Compact flash and updating the kernel
	-$(SUDO) umount cflash
	-rm -rf cflash
	-mkdir cflash

	$(SUDO) mount $(CFLASH_DEV) $(CFLASH_MOUNT)

	$(SUDO) cp $(KERNEL2X00) $(CFLASH_MOUNT)
	-$(SUDO) rm -rf $(CFLASH_MOUNT)/lib/modules/*
	$(SUDO) cp -Ra boot/lib/modules/* $(CFLASH_MOUNT)/lib/modules

	$(SUDO) umount $(CFLASH_MOUNT)
	-$(SUDO) rmdir cflash
	@echo Slide out the Compact Flash and into the Netvista ready to boot!

#
# Custom step : Copy the complete Debian etch root filesystem, kernel image, and kernel modules into the compact flash
#
cflash: $(CFLASH_CFILE)
$(CFLASH_CFILE): $(ROOTFS_CFILE)

	@echo Preparing the Compact Flash drive...
	-$(SUDO) umount $(CFLASH_MOUNT)
	-$(SUDO) rm -rf $(CFLASH_MOUNT)
	$(SUDO) mke2fs $(CFLASH_DEV)

	@echo Mounting the Compact Flash
	mkdir $(CFLASH_MOUNT)
	$(SUDO) mount $(CFLASH_DEV) $(CFLASH_MOUNT)

	@echo Copying the root file system into the Flash Card
	$(SUDO) cp -v -a -R $(ROOTFS)/* $(CFLASH_MOUNT)
	$(SUDO) umount $(CFLASH_MOUNT)
	$(SUDO) rmdir $(CFLASH_MOUNT)

	touch $(CFLASH_CFILE)
	@echo Compact Flash is ready to boot!

#
# Custom step : Create an ISO image to easily distribute pus-pus
#
pusimage: $(PUSIMAGE_CFILE)
$(PUSIMAGE_CFILE):

	@echo Preparing Pus-Pus version $(PUSPUS_VERSION).$(PUSPUS_SUBLEVEL) image file
	-rm $(PUSIMAGE_CFILE)
	-rm $(PUSIMAGE_MD5SUM)

	@echo Building the Imag image
	dd if=/dev/zero of=$(PUSIMAGE_CFILE) bs=10 count=30MB
	mke2fs -F $(PUSIMAGE_CFILE)
	-$(SUDO) losetup -d $(DEVLOOP)
	-$(SUDO) losetup $(DEVLOOP) $(PUSIMAGE_CFILE)
	-mkdir ./pusimage
	-$(SUDO) mount $(DEVLOOP) pusimage

	$(SUDO) cp -v -a -R $(ROOTFS)/* ./pusimage
	$(SUDO) umount ./pusimage
	rmdir pusimage
	$(SUDO) losetup -d $(DEVLOOP)
	cd boot && md5sum -b $(PUSIMAGE).img > $(PUSIMAGE).md5

	@echo PusPus image version $(PUSPUS_VERSION).$(PUSPUS_SUBLEVEL) has been created
