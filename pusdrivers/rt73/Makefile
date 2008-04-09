######################################################################
#	Module Name: Makefile
#	Abstract: Makefile for rt73 linux driver on kernel series 2.6 
######################################################################
PLATFORM=PC
#PLATFORM=CMPC

#Enable for wpa_supplicant's spcific driver "driver_ralink.c", default enabled.
HAS_RALINK_WPA_SUPPLICANT_SUPPORT=y

#Enable for wpa_supplicant's generic driver "driver_wext.c", used for NetworkManager
HAS_NATIVE_WPA_SUPPLICANT_SUPPORT=n


VERSION_HEADER = $(KERNEL_PATH)/include/linux/utsrelease.h
ifeq (,$(wildcard $(VERSION_HEADER)))
VERSION_HEADER = $(KERNEL_PATH)/include/linux/version.h
ifeq (,$(wildcard $(VERSION_HEADER)))
$(error Kernel in $(KERNEL_PATH) is not configured)
endif
endif

# Kernel Makefile doesn't always know the exact kernel version, so we
# get it from the kernel headers instead and pass it to make.
KERNELRELEASE = $(shell sed -ne 's/"//g;s/^\#define UTS_RELEASE //p' \
		  $(VERSION_HEADER))

INSTALL_MOD_DIR = kernel/drivers/net/wireless
DEPMOD = /sbin/depmod

WFLAGS := -Wall -Wstrict-prototypes -Wno-trigraphs

ifeq ($(HAS_RALINK_WPA_SUPPLICANT_SUPPORT),y)
WFLAGS += -DRALINK_WPA_SUPPLICANT_SUPPORT
endif

ifeq ($(HAS_NATIVE_WPA_SUPPLICANT_SUPPORT),y)
WFLAGS += -DNATIVE_WPA_SUPPLICANT_SUPPORT
endif

## Comment/uncomment the following line to enable/disable debugging
#CFLAGS += -DDBG

CFLAGS += $(WFLAGS)

PWD = $(shell pwd)

# added KBUILD_FLAGS for module install rule
KBUILD_FLAGS = -C $(KERNEL_PATH) M=$(PWD) KERNELRELEASE=$(KERNELRELEASE)


ifeq ($(PLATFORM),PC)
LINUX_SRC =/lib/modules/$(shell uname -r)/build
endif
ifeq ($(PLATFORM),CMPC)
LINUX_SRC = /home/fonchi/vendor/kernel-default-2.6.21/linux-2.6.21
endif

CFLAGS += -I$(LINUX_SRC)/include

obj-m := rt73.o

rt73-objs := \
	rtmp_main.o \
	mlme.o \
	connect.o \
	rtusb_bulk.o \
	rtusb_io.o \
	sync.o \
	assoc.o \
	auth.o \
	auth_rsp.o \
	rtusb_data.o \
	rtmp_init.o \
	sanity.o \
	rtmp_wep.o \
	rtmp_info.o \
	rtmp_tkip.o \
	wpa.o md5.o

ifeq ($(HAS_NATIVE_WPA_SUPPLICANT_SUPPORT),y)
rt73-objs += rtmp_wext.o
endif

## Configuration files on SuSE
#NDDIR=/etc/sysconfig/network
#MOD_CONF=/etc/modprobe.d/module-renames

## NDDIR/ifcfg-rausb0
ND_CONF=/etc/sysconfig/network-scripts/ifcfg-rausb0

ifdef NDDIR
	NDDIR := $(NDDIR)
else
	NDDIR := /etc/sysconfig/network-scripts
endif

ifdef MOD_CONF
	MOD_CONF := $(MOD_CONF)	
else
	MOD_CONF := /etc/modprobe.conf 
endif

all: modules install

modules:
	$(MAKE) -C $(LINUX_SRC) $(KBUILD_FLAGS) modules

clean:
	rm -rf *.o *~ .*.cmd *.ko *.mod.c .tmp_versions built-in.o

install:
	$(MAKE) $(KBUILD_FLAGS) modules_install \
		INSTALL_MOD_DIR="$(INSTALL_MOD_DIR)"
	$(DEPMOD) -ae -b $(INSTALL_MOD_PATH) $(KERNELRELEASE)

config:
	@touch config.mk
	@./Configure
