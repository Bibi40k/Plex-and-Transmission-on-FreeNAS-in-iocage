#!/bin/bash

#####################################################################################
# Title: Plex & Transmission iocage jail under FreeNAS                              #
# Author: Bibi40k                                                                   #
# Repository: https://github.com/Bibi40k/Plex-and-Transmission-on-FreeNAS-in-iocage #
#####################################################################################

# First of all, we clear the screen
clear


# Getting installer dir ( /root/OpenVPN-on-FreeNAS-in-iocage )
CWD="`pwd`"
SCRIPT="`which $0`"
RELDIR="`dirname $SCRIPT`"
cd "$RELDIR"
DIR="`pwd`"
cd "$CWD"


source $DIR/scripts/colors.sh # messages' colors
source $DIR/scripts/check_user.sh # checks minimum requirements

CheckUser # user must be root

# Update script to the latest version
echo
echo -e "${INFO} Checking for script updates..."
echo
cd ${DIR}
git pull


exit



# Getting installer dir ( /root/Plex-and-Transmission-on-FreeNAS-in-Iocage )
SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "${SCRIPT}")


# Import scripts from /scripts dir
source ${SCRIPTPATH}/scripts/env.sh # few vars
source ${SCRIPTPATH}/scripts/dirs.sh # create all dir structure
source ${SCRIPTPATH}/scripts/files.sh # create/copy all files
source ${SCRIPTPATH}/scripts/defaults.sh # default vars & constants
source "${FVARS}" # custom vars we created in 'CUSTOM_BKP_DIR/jail.vars'

source ${SCRIPTPATH}/scripts/jail.sh # install Jail
source ${SCRIPTPATH}/scripts/plex.sh # plex configuration
source ${SCRIPTPATH}/scripts/crontab.sh # adding cron job



iocage exec ${CUSTOM_JAIL_NAME} "pkg upgrade -y"
iocage restart ${CUSTOM_JAIL_NAME}

echo "Installation Complete!"
echo "Log in and configure your server by browsing to:"
echo "http://${CUSTOM_JAIL_IP}:32400/web"