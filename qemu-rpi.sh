#!/bin/bash

# Finally!
# After many headaches and bullshittery, we can finally boot ubuntu_arm64+rasp on qemu
# see also:
# - img2qcow.sh
# - get_boot_files-QEMU.sh

QCOWFILE=<path/to/image.qcow2>
KERNEL=<path/to/kernel>
INITRD=<path/to/initrd.img>
DTB=<path/to/devicetree.dtb>


# check the -append line, you may (probably) need to adjust the root= according to your image file
# this version of the script has no network support - yet. Will add that soon.
qemu-system-aarch64 \
  -M raspi3 \
  -m 1024 \
  -drive "file=$QCOWFILE" \
  -kernel $KERNEL \
  -initrd $INITRD \
  -append 'dwc_otg.lpm_enable=0 earlycon=pl011,mmio32,0x3f201000 console=ttyAMA0 root=LABEL=writable rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait maxcpus=4' \
  -no-reboot \
  -serial mon:stdio \
  -dtb $DTB \
