#
# Top level makefile for all Netvista 8363 drivers for Pus Pus
#
# The at76_usb is a kernel driver to support the Atmel wireless devices, and it can be found at:
#   http://at76c503a.berlios.de/
#
# The firmware is integrated by downloading the Debian package atmel-firmware.
#

.PHONY: modules install

modules:
	$(MAKE) -C at76_usb-0.17 modules
	$(MAKE) -C rt73 modules

install:
	$(MAKE) -C at76_usb-0.17 install
	$(MAKE) -C rt73 install
