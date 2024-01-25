#!/bin/sh

# Check for root
[ $(id -u) -ne 0 ] && echo "Script must be executed with sudo" && exit 0

apt-get update
apt-get -y upgrade
apt-get -y autoremove

# Stop/disable some irrelevant services
for p in avahi-daemon.service avahi-daemon.socket cups.service cups-browsed.service ModemManager.service ufw.service apt-daily-upgrade.timer apt-daily.timer
do
   systemctl stop ${p}
   systemctl mask ${p}
done

# Install misc
apt-get -y install curl build-essential

# Add user to vboxsf group for shared folder
# usermod -aG vboxsf user

# Cleanup apt-get
apt-get clean

