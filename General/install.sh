#!/bin/sh

# Check for root
if [ $(id -u) -ne 0 ]
then
   echo "This script should be executed as root"
   exit 0
fi

# Stop/disable some irrelevant services
for p in avahi-daemon.service avahi-daemon.socket casper.service casper-md5check.service cups.service cups-browsed.service ModemManager.service ufw.service
do
   systemctl stop ${p}
   systemctl mask ${p}
done

# Add user to vboxsf group for shared folder
usermod -aG vboxsf user
