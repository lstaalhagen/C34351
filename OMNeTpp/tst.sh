#!/bin/sh

cd /home/user/omnetpp-6.0.2

USERNAME=$(who am i|cut -d ' ' -f 1)
echo $USERNAME

HOMEDIR=$(eval echo "~$USERNAME")
echo $HOMEDIR

rm -f $HOMEDIR/.local/share/applications/$OMNETVER-ide.desktop
rm -f $HOMEDIR/.local/share/applications/$OMNETVER-shell.desktop

echo $(realpath $0)
# install -m 0755 $(dirname $0)/omnetpp /usr/local/bin/omnetpp
