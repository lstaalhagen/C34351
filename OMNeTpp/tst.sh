#!/bin/sh

CURRDIR=$(realpath .)

cd /home/user/omnetpp-6.0.2

USERNAME=$(who am i|cut -d ' ' -f 1)
# echo $USERNAME

HOMEDIR=$(eval echo "~$USERNAME")
# echo $HOMEDIR

rm -f $HOMEDIR/.local/share/applications/$OMNETVER-ide.desktop
rm -f $HOMEDIR/.local/share/applications/$OMNETVER-shell.desktop

# echo ${CURRDIR}
install -m 0755 ${CURRDIR}/omnetpp /usr/local/bin/omnetpp
