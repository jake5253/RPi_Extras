#!/bin/bash

# Finally!
# After many headaches and bullshittery, we can finally boot ubuntu_arm64+rasp on qemu
# see also:
# - img2qcow.sh



qemu-system-aarch64 \
  -M raspi3 \
  -m 1024 \
  -drive "file=ubuntu.qcow2" \
  -kernel boot/Image \
  -initrd boot/initrd.img \
  -append 'dwc_otg.lpm_enable=0 earlycon=pl011,mmio32,0x3f201000 console=ttyAMA0 root=LABEL=writable rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait maxcpus=4' \
  -no-reboot \
  -serial mon:stdio \
  -dtb boot/bcm2711-rpi-4-b.dtb \
