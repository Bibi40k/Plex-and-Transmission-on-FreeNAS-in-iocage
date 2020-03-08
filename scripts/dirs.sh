#!/bin/bash
# This script will create all necessary dirs & store them in vars


mkdir -p ${TMP_CUSTOM_DBKP}/plex-configsss
ls -la ${TMP_CUSTOM_DBKP}

# Create dirs, copy dummy vars file and set bkp dir
DIRS=(${TMP_CUSTOM_DBKP}/plex-configs,${TMP_CUSTOM_DBKP}/transmission-configs)
mkdir -p -- "${DIRS[@]}"


exit 1;

### DIRS ###
DCONFIG="${HOME}/openvpn-configs"
DSERVER="${DCONFIG}/server"
DCLIENTS="${DCONFIG}/clients"
DKEYS="${DSERVER}/keys"
DLOGS="${DCONFIG}/logs"

