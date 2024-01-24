#!/bin/sh

# Check for root
[ $(id -u) -ne 0 ] && echo "Script must be executed with sudo" && exit

# Install Open vSwitch packages
apt-get install -y openvswitch-common openvswitch-switch

# Install Mininet-wifi
git clone https://github.com/intrig-unicamp/mininet-wifi
cd mininet-wifi
util/install.sh -Wlnfv
