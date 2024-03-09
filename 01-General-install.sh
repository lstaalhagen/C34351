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
apt-get -y install curl build-essential gcc-12 wireshark

# Add user to vboxsf group for shared folder
# usermod -aG vboxsf user

# Cleanup apt-get
apt-get clean

# Fix Grub
sed -i 's/GRUB_TIMEOUT_STYLE=.*/GRUB_TIMEOUT_STYLE=menu/g' /etc/default/grub
sed -i 's/GRUB_TIMEOUT=.*/GRUB_TIMEOUT=2/g' /etc/default/grub
update-grub

# Set initial font for xterm
XRESOURCES=/home/user/.Xresources
if [ -s $XRESOURCES ]; then
  grep -q -e "^xterm*faceName:"
  if [ $? -ne 0 ]; then
    echo "xterm*faceName: Monospace" >> $XRESOURCES
    echo "xterm*faceSize: 14" >> $XRESOURCES
    sudo -u user "xrdb -merge $XRESOURCES
  fi
else
  echo "xterm*faceName: Monospace" > $XRESOURCES
  echo "xterm*faceSize: 14" >> $XRESOURCES
  sudo -u user "xrdb -merge $XRESOURCES
fi
