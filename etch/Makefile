#
#  This makefile will download and tarball a minimal Debian Etch distro ready to prepare a root filesystem
#
#  You might want to replace DEBIAN_MIRROR by your prefered closest Debian archives mirror.
#

ETCH_TAR=etch.tar
DEBIAN_MIRROR=ftp://ftp.rediris.es/debian/
ATMEL_FIRMWARE=$(DEBIAN_MIRROR)/pool/non-free/a/atmel-firmware/atmel-firmware_1.3-2_all.deb
ZD1211_FIRMWARE=$(DEBIAN_MIRROR)/pool/non-free/z/zd1211-firmware/zd1211-firmware_2.16.0.0-0.1_all.deb

all: nope

prepare: $(ETCH_TAR)
$(ETCH_TAR):

	@echo Downloading the Debian Etch minimal system
	debootstrap --make-tarball $(ETCH_TAR) --include=$(INCLUDE_PKGS) etch debian $(DEBIAN_MIRROR)

	@echo Downloading extra packages
	-cd extra && wget $(ATMEL_FIRMWARE)
	-cd extra && wget $(ZD1211_FIRMWARE)
