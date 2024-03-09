#!/usr/bin/env bash

# Some miscellaneous tweaks and fixes 

# Check for root
[ $(id -u) -ne 0 ] && echo "Script must be executed with sudo" && exit 0
REALUSER=${SUDO_USER}
[ -z "${REALUSER}" ] && echo "Environment variable $SUDO_USER not set as expected" && exit

# Add (real) users to sudoers file
grep -q -e "^${REALUSER}" /etc/sudoers
if [ $? -ne 0]; then
  echo -e "${REALUSER}\tALL = NOPASSWD: ALL" >> /etc/sudoers
fi

#
