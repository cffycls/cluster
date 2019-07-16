#!/bin/bash

if [ ! -e /opt/swapfile ]; 
then 
	touch /opt/swapfile && echo "touch swapfile OK"; 
else
	echo "swapfile exists";	
fi

mkswap /opt/swapfile && swapon /opt/swapfile

