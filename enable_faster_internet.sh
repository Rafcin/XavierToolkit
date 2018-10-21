#!/bin/bash

#Enables larger packet transfer on the Xavier.
#Set to mode 8

echo "Setting iwlwifi options to mode 8 "
echo "options iwlwifi 11n_disable=8" | sudo tee -a /etc/modprobe.d/iwlwifi.conf
