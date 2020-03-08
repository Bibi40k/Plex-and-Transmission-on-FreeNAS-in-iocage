#!/bin/bash
# Build Plex & Transmission Iocage Jail under FreeNAS


# Getting installer dir ( /root/Plex-and-Transmission-on-FreeNAS-in-Iocage )
SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "${SCRIPT}")
POOL_NAME=$(zpool list | grep mnt | awk '{print $1;}')

\cp -n "${SCRIPTPATH}/src/env.vars" "${SCRIPTPATH}/env.vars"
source "${SCRIPTPATH}/env.vars"

if [ -f "${DBKP}/jail.vars" ]; then
  source "${DBKP}/jail.vars"
fi


# $CUSTOM_BACKUP_DIR
echo ""
if [ ! -z ${CUSTOM_BKP_DIR} ]; then
  read -p "We already set BackUp dir as [${CUSTOM_BKP_DIR}]: " TMP_CUSTOM_BKP_DIR
  TMP_CUSTOM_BKP_DIR=${TMP_CUSTOM_BKP_DIR:-$CUSTOM_BKP_DIR}
else
  read -p "BackUp dir not set, default BackUp dir is [${DBKP}]: " TMP_CUSTOM_BKP_DIR
  TMP_CUSTOM_BKP_DIR=${TMP_CUSTOM_BKP_DIR:-$DBKP}
fi

\cp -n "${SCRIPTPATH}/src/dummy-jail.vars" "${TMP_CUSTOM_BKP_DIR}/jail.vars"
sed -i "" "s|CUSTOM_BKP_DIR=.*|CUSTOM_BKP_DIR=\"${TMP_CUSTOM_BKP_DIR}\"|" "${TMP_CUSTOM_BKP_DIR}/jail.vars"
sed -i "" "s|DBKP=.*|DBKP=\"${TMP_CUSTOM_BKP_DIR}\"|" "${SCRIPTPATH}/env.vars"

# Import scripts from /scripts dir
source ${SCRIPTPATH}/scripts/dirs.sh # create all dir structure
