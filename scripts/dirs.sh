#!/bin/bash
# This script will create all necessary dirs & store them in vars

# Setting workdir and backup dir
POOL_NAME=$(zpool list | grep mnt | awk '{print $1;}')
echo "POOL_NAME is $POOL_NAME"

# Default BackUp dir
DBKP="/mnt/${POOL_NAME}/BackUP/Jails"

# $CUSTOM_BACKUP_DIR
echo ""
if [ ! -z $CUSTOM_DBKP ]; then
  read -p "We already set BackUp dir as [${CUSTOM_DBKP}]: " TMP_CUSTOM_DBKP
  TMP_CUSTOM_DBKP=${TMP_CUSTOM_DBKP:-$CUSTOM_DBKP}
else
  read -p "BackUp dir not set, default BackUp dir is [${DBKP}]: " TMP_DBKP
  TMP_DBKP=${TMP_DBKP:-$DBKP}
fi

exit 1;


DIRS=(../${SCRIPTPATH}/plex-configs,../${SCRIPTPATH}/transmission-configs)
mkdir -p -- "${DIRS[@]}"

exit 1;

### DIRS ###
DCONFIG="${HOME}/openvpn-configs"
DSERVER="${DCONFIG}/server"
DCLIENTS="${DCONFIG}/clients"
DKEYS="${DSERVER}/keys"
DLOGS="${DCONFIG}/logs"

