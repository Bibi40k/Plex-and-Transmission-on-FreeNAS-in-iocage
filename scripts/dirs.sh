#!/bin/bash
# This script will create all necessary dirs & store them in vars

# Setting workdir and backup dir
POOL_NAME=$(zpool list | grep mnt | awk '{print $1;}')

# Default BackUp dir
DBKP="/mnt/${POOL_NAME}/BackUP/Jails"

# $CUSTOM_BACKUP_DIR
echo ""
if [ ! -z $CUSTOM_DBKP ]; then
  read -p "We already set BackUp dir as [${CUSTOM_DBKP}]: " TMP_CUSTOM_DBKP
  TMP_CUSTOM_DBKP=${TMP_CUSTOM_DBKP:-$CUSTOM_DBKP}
else
  read -p "BackUp dir not set, default BackUp dir is [${DBKP}]: " TMP_CUSTOM_DBKP
  TMP_CUSTOM_DBKP=${TMP_CUSTOM_DBKP:-$DBKP}
fi

# Create dirs, copy dummy vars file and set bkp dir
DIRS=(../${TMP_CUSTOM_DBKP}/plex-configs,../${TMP_CUSTOM_DBKP}/transmission-configs)
mkdir -p -- "${DIRS[@]}"
\cp -n "${SCRIPTPATH}/src/dummy-jail.vars" "${TMP_CUSTOM_DBKP}/jail.vars"
sed -i "" "s/CUSTOM_BKP_DIR=.*/CUSTOM_BKP_DIR=\"${TMP_CUSTOM_DBKP}\"/" ${FVARS}


exit 1;

### DIRS ###
DCONFIG="${HOME}/openvpn-configs"
DSERVER="${DCONFIG}/server"
DCLIENTS="${DCONFIG}/clients"
DKEYS="${DSERVER}/keys"
DLOGS="${DCONFIG}/logs"

