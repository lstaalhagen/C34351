#!/usr/bin/env bash

# Check for root 
[ $(id -u) -ne 0 ] && echo "Script must be executed with sudo" && exit
REALUSER=${SUDO_USER}
[ -z "${REALUSER}" ] && echo "Environment variable $SUDO_USER not set as expected" && exit

# Install additional packages for both MQTT and CoAP
apt-get update
apt-get -y install mosquitto mosquitto-clients asciidoc 
apt-get clean

# Stop and mask the MQTT broker service, since we want to start it manually in the exercises
systemctl stop mosquitto.service
systemctl mask mosquitto.service

# Download and install libcoap - takes some minutes
git clone https://github.com/obgm/libcoap
cd libcoap
./autogen.sh
./configure --enable-examples --enable-documentation
make
make install
cd ..

# Fix - set LD_LIBRARY_PATH environment variable in root's .bashrc so that it's set when coap-programs
# are executed with sudo. Should perhaps have been set in user's .bashrc, but then sudo should be called
# with the -E option.
grep -q -e "^export LD_LIBRARY_PATH=" /root/.bashrc
if [ $? -ne 0 ]; then
  echo "export LD_LIBRARY_PATH=/usr/local/lib" >> /root/.bashrc
fi

# HACK GLOXBDITWPFR
# Hack for setting PS1 to name of namespace if not default namespace
grep -q -e "GLOXBDITWPFR" /root/.bashrc
if [ $? -ne 0 ]; then
  echo '# HACK GLOXBDITWPFR' >> /root/.bashrc
  echo 'if [ ! -z "$(ip netns identify)" ]; then' >> /root/.bashrc
  echo '  export PS1="$(ip netns identify):\w# "' >> /root/.bashrc
  echo 'fi' >> /root/.bashrc
fi

# Make directories and copy necessary scripts
mkdir -p /home/${REALUSER}/MQTT
cp Files/netgenerate.sh Files/clearnet.sh Files/mosquitto.conf Files/mqtt-init.sh /home/${REALUSER}/MQTT
chown -R ${REALUSER}: /home/${REALUSER}/MQTT
mkdir -p /home/${REALUSER}/CoAP
cp Files/netgenerate.sh Files/clearnet.sh /home/${REALUSER}/CoAP
chown -R ${REALUSER}: /home/${REALUSER}/CoAP
