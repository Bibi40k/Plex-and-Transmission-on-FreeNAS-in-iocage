  #!/bin/bash
# Build Plex & Transmission Iocage Jail under FreeNAS


# Getting installer dir ( /root/Plex-and-Transmission-on-FreeNAS-in-Iocage )
CWD="`pwd`"
SCRIPT="`which $0`"
RELDIR="`dirname $SCRIPT`"
cd "$RELDIR"
DIR="`pwd`"
cd "$CWD"

echo "SCRIPTPATH is $SCRIPTPATH"


# Import scripts from /scripts dir
source ${DIR}/scripts/dirs.sh # create all dir structure
