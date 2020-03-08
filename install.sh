#!/bin/bash
# Build Plex & Transmission Iocage Jail under FreeNAS


# Getting installer dir ( /root/Plex-and-Transmission-on-FreeNAS-in-Iocage )
SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "${SCRIPT}")
POOL_NAME=$(zpool list | grep mnt | awk '{print $1;}')
source "${SCRIPTPATH}/env.vars"
\cp -n "${SCRIPTPATH}/src/env.vars" "${SCRIPTPATH}/env.vars"
[ -f "${DBKP}/jail.vars" ] source "${DBKP}/jail.vars"

# $CUSTOM_BACKUP_DIR
echo ""
if [ ! -z $CUSTOM_DBKP ]; then
  read -p "We already set BackUp dir as [${CUSTOM_DBKP}]: " TMP_CUSTOM_DBKP
  TMP_CUSTOM_DBKP=${TMP_CUSTOM_DBKP:-$CUSTOM_DBKP}
else
  read -p "BackUp dir not set, default BackUp dir is [${DBKP}]: " TMP_CUSTOM_DBKP
  TMP_CUSTOM_DBKP=${TMP_CUSTOM_DBKP:-$DBKP}
fi

\cp -n "${SCRIPTPATH}/src/dummy-jail.vars" "${TMP_CUSTOM_DBKP}/jail.vars"
sed -i "" "s|CUSTOM_BKP_DIR=.*|CUSTOM_BKP_DIR=\"${TMP_CUSTOM_DBKP}\"|" "${TMP_CUSTOM_DBKP}/jail.vars"
sed -i "" "s|DBKP=.*|DBKP=\"${TMP_CUSTOM_DBKP}\"|" "${SCRIPTPATH}/env.vars"

# Import scripts from /scripts dir
source ${SCRIPTPATH}/scripts/dirs.sh # create all dir structure
