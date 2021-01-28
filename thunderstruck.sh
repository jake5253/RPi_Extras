#!/bin/bash

# This script converts vcgencmd's get_throttled into human-readable sentences.
# Name derived from the shittiest band, because I dislike them about as much as I
# dislike the damn lightning bolt in the top right of my screen constantly!
# There's not an undervoltage situation occuring, damnit! #ITHINKMYPIBROKE

CTH=$(vcgencmd get_throttled | cut -d'x' -f2-);
CTB=$(echo "ibase=16; obase=2; $CTH" | bc);
echo "vcgencmd: 0x$CTH";
[[ 0 -eq $CTB ]] && echo "No throttle detected";
for i in $(seq 0 20); do
 BINSPOT=$(echo ${CTB:$i:1});
 if [[ $BINSPOT -eq 1 ]]; then
  case $i in
    0) echo "Under-voltage Detected";;
    1) echo "Arm frequency capped";;
    2) echo "Currently throttled";;
    3) echo "Soft tempurature limit active";;
   16) echo "Under-voltage has occured";;
   17) echo "Arm frequency cap has occured";;
   18) echo "Throttling has occured";;
   19) echo "Soft tempurature limit has occured";;
  esac
 fi
done
