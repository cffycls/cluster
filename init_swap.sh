#!/bin/bash

if [ ! -e /opt/swapfile ]; 
then 
	touch /opt/swapfile && chmod 0644 /opt/swapfile && echo "touch swapfile OK"; 
	dd if=/dev/zero of=/opt/swapfile bs=1M count=2048
else
	echo "swapfile exists";	
fi

mkswap /opt/swapfile && swapon /opt/swapfile

