#!/bin/bash
# This script will create all necessary dirs & store them in vars

# Setting workdir and backup dir
POOL_NAME=$(zpool list | grep mnt | awk '{print $1;}')



DIRS=(../${SCRIPTPATH}/plex-configs,../${SCRIPTPATH}/transmission-configs)
mkdir -p -- "${DIRS[@]}"

exit 1;

### DIRS ###
DCONFIG="${HOME}/openvpn-configs"
DSERVER="${DCONFIG}/server"
DCLIENTS="${DCONFIG}/clients"
DKEYS="${DSERVER}/keys"
DLOGS="${DCONFIG}/logs"

