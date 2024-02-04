#!/bin/sh

# Check for root
[ $(id -u) -ne 0 ] && echo "Script must be executed with sudo" && exit

# Install Open vSwitch packages
apt-get install -y openvswitch-common openvswitch-switch

# Hack for libssl3 version confusion
apt-get install -y libssl3=3.0.2-0ubuntu1.12

# Install Mininet-wifi
git clone https://github.com/intrig-unicamp/mininet-wifi
cd mininet-wifi
util/install.sh -Wlnfv
cd ..
rm -rf mininet-wifi

# Cleanup apt-get
apt-get clean
