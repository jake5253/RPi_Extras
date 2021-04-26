#!/bin/bash

IMGFILE=<path/to/image.img>
QCOWFILE=<path/where/to/create/qcow.qcow2>

# first, we need to make the img size divisable by 2 (4GB,8GB,16GB,32GB,64GB...)
qemu-img resize $IMGFILE 16G

# now we make an empty qcow2 file
qemu-img create $QCOWFILE 16G

# now load the NiceBigDick module (thats what NBD stands for, right?)
sudo modprobe nbd
# mount the empty qcow2 file
sudo qemu-nbd -c /dev/nbd0 $QCOWFILE
# and copy the contents of .img to .qcow2
sudo dd if=$IMGFILE of=$QCOWFILE status=progress bs=8M
# now we can unmount the .qcow2
sudo qemu-nbd -d $QCOWFILE
# and unload the module (may result in an error..if so, fuck it. just leave the module *shrug*
sudo rmmod nbd

echo "Your converted img2qcow file is here: $QCOWFILE"
