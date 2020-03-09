#!/bin/bash
# This script will create all necessary dirs & store them in vars


# Create dirs, copy dummy vars file and set bkp dir
DIRS=("${TMP_CUSTOM_BKP_DIR}"/"${TMP_CUSTOM_JAIL_NAME}"/{plex-config,transmission-config})
mkdir -p -- "${DIRS[@]}"


### DIRS ###
DBKP="${TMP_CUSTOM_BKP_DIR}/${TMP_CUSTOM_JAIL_NAME}"
DPLEX="${DCONFIG}/plex-config"
DTRANSMISSION="${DCONFIG}/transmission-config"
DDOWNLOAD="/mnt/${POOL_NAME}/FTP"
# DLOGS="${DCONFIG}/logs"

