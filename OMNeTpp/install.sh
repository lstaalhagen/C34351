#!/bin/sh

# Check for root
[ $(id -u) -ne 0 ] && echo "Script must be executed with sudo" && exit

python -m pip install scipy numpy pandas matplotlib seaborn posix_ipc

# Download and install OMNeT++
cd /home/user
curl https://github.com/omnetpp/omnetpp/releases/download/omnetpp-6.0.2/omnetpp-6.0.2-linux-x86_64.tgz
