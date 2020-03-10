#!/bin/bash
# Build Plex & Transmission Iocage Jail under FreeNAS


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