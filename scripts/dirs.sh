#!/bin/bash
# This script will create all necessary dirs & store them in vars


# Create dirs, copy dummy vars file and set bkp dir
DIRS=("${TMP_CUSTOM_BKP_DIR}"/"${TMP_CUSTOM_JAIL_NAME}"/{plexdata,plex-config,transmission-config})
mkdir -p -- "${DIRS[@]}"


### DIRS ###
DBKP="${TMP_CUSTOM_BKP_DIR}/${TMP_CUSTOM_JAIL_NAME}"
DPLEXDATA="${DBKP}/plexdata"
DPLEXCONFIG="${DBKP}/plex-config"
DTRANSMISSION="${DBKP}/transmission-config"
DDOWNLOAD="/mnt/${POOL_NAME}/FTP"
# DLOGS="${DCONFIG}/logs"

