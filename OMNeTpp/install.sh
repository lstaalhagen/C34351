#!/bin/sh

# Check for root
[ $(id -u) -ne 0 ] && echo "Script must be executed with sudo" && exit

# Prerequisites
apt-get install clang lld gdb bison flex perl swig qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools libqt5opengl5-dev libxml2-dev zlib1g-dev doxygen graphviz libwebkit2gtk-4.0-37
python -m pip install scipy numpy pandas matplotlib seaborn posix_ipc

# Get curl if not installed
which curl &>/dev/null || apt-get -y install curl

# Download and install OMNeT++
OMNETVER="omnetpp-6.0.2"
URL="https://github.com/omnetpp/omnetpp/releases/download/$OMNETVER/$OMNETVER-linux-x86_64.tgz"
TGZFILE=$(basename $URL)

cd /opt
curl -LG $URL -o $TGZFILE || exit
tar xzf $TGZFILE
rm -f $TGZFILE
cd $OMNETVER
sed -i 's/WITH_OSG=yes/WITH_OSG=no/g' configure.user
./source setenv && ./configure && make
