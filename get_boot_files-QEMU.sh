#!/bin/bash

IMGFILE=<path/to/image.img>
WORKINGDIR=<path/to/where/you/want/bootfiles>

sudo kpartx -auv $IMGFILE
sudo mount /dev/mapper/loop0p1 /mnt
cp -r /mnt/* $WORKINGDIR/
sudo umount /mnt
sudo kpartx -d $IMGFILE
