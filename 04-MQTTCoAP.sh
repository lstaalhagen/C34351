#!/usr/bin/env bash

# Check for root 
[ $(id -u) -ne 0 ] && echo "Script must be executed with sudo" && exit

apt-get update
apt-get -y install mosquitto mosquitto-clients asciidoc 

systemctl stop mosquitto.service
systemctl mask mosquitto.service

# HACK GLOXBDITWPFR
grep -q -e "GLOXBDITWPFR" /root/.bashrc
if [ $? -ne 0 ]; then
  echo '# HACK GLOXBDITWPFR' >> /root/.bashrc
  echo 'if [ ! -z "$(ip netns identify)" ]; then' >> /root/.bashrc
  echo '  export PS1="$(ip netns identify):\w# "' >> /root/.bashrc
  echo 'fi' >> /root/.bashrc
fi
