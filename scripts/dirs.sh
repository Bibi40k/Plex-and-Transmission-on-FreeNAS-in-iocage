#!/bin/bash
# This script will create all necessary dirs & store them in vars


# Create dirs, copy dummy vars file and set bkp dir
DIRS=("${TMP_CUSTOM_BKP_DIR}/plex-configs,transmission-configs")
mkdir -p -- "${DIRS[@]}"
ls -la "${TMP_CUSTOM_BKP_DIR}"


exit 1;

### DIRS ###
DCONFIG="${HOME}/openvpn-configs"
DSERVER="${DCONFIG}/server"
DCLIENTS="${DCONFIG}/clients"
DKEYS="${DSERVER}/keys"
DLOGS="${DCONFIG}/logs"

