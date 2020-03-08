#!/bin/bash

# Getting Pool Name
POOL_NAME=$(zpool list | grep mnt | awk '{print $1;}')



# Copy 'dummy-jail.vars' without overwrite and then load vars
\cp -n "${SCRIPTPATH}/src/dummy-jail.vars" "${SCRIPTPATH}/jail.vars"
source "${SCRIPTPATH}/jail.vars"
if [ -f "${CUSTOM_BKP_DIR}/jail.vars" ]; then
  source "${CUSTOM_BKP_DIR}/jail.vars"
fi



# $CUSTOM_BACKUP_DIR
echo ""
if [ ! -z "${CUSTOM_BKP_DIR}" ]; then
  read -p "We already set BackUp dir as [${CUSTOM_BKP_DIR}]: " TMP_CUSTOM_BKP_DIR
  TMP_CUSTOM_BKP_DIR=${TMP_CUSTOM_BKP_DIR:-$CUSTOM_BKP_DIR}
else
  DEF_DBKP="/mnt/${POOL_NAME}/BackUP/Jails"
  read -p "BackUp dir not set, default BackUp dir is [${DEF_DBKP}]: " TMP_CUSTOM_BKP_DIR
  TMP_CUSTOM_BKP_DIR=${TMP_CUSTOM_BKP_DIR:-$DEF_DBKP}
fi



# $CUSTOM_JAIL_NAME
echo ""
if [ ! -z $CUSTOM_JAIL_NAME ]; then
  read -p "We already set Iocage Name as [${CUSTOM_JAIL_NAME}]: " TMP_CUSTOM_JAIL_NAME
  TMP_CUSTOM_JAIL_NAME=${TMP_CUSTOM_JAIL_NAME:-$CUSTOM_JAIL_NAME}
else
  DEF_JNAME="MediaBox"
  read -p "Iocage name not set, default Name is [${DEF_JNAME}]: " TMP_CUSTOM_JAIL_NAME
  TMP_CUSTOM_JAIL_NAME=${TMP_CUSTOM_JAIL_NAME:-$DEF_JNAME}
fi



# $CUSTOM_USE_PLEXPASS
echo ""
if [ ! -z $CUSTOM_USE_PLEXPASS ]; then
  read -p "We already set use PlexPass option as [${CUSTOM_USE_PLEXPASS}]: " TMP_CUSTOM_USE_PLEXPASS
  TMP_CUSTOM_USE_PLEXPASS=${TMP_CUSTOM_USE_PLEXPASS:-$CUSTOM_USE_PLEXPASS}
else
  DEF_USE_PLEXPASS="no"
  read -p "Use PlexPass not set, default option is [yes|no, def:${DEF_USE_PLEXPASS}]: " TMP_CUSTOM_USE_PLEXPASS
  TMP_CUSTOM_USE_PLEXPASS=${TMP_CUSTOM_USE_PLEXPASS:-$DEF_USE_PLEXPASS}
fi



FVARS="${TMP_CUSTOM_BKP_DIR}/${TMP_CUSTOM_JAIL_NAME}/jail.vars"
FPKG="${TMP_CUSTOM_BKP_DIR}/${TMP_CUSTOM_JAIL_NAME}/pkg.json"

\cp -n "${SCRIPTPATH}/src/dummy-jail.vars" "${FVARS}"
\cp -n "${SCRIPTPATH}/src/jail/pkg.json" "${FPKG}"
if [ ${TMP_CUSTOM_USE_PLEXPASS} -eq yes ]; then
  sed -i "" "s|plexmediaserver|plexmediaserver-plexpass|" "${FPKG}"
fi



sed -i "" "s|CUSTOM_JAIL_NAME=.*|CUSTOM_JAIL_NAME=|\"${TMP_CUSTOM_JAIL_NAME}\"|" "${FVARS}"
sed -i "" "s|CUSTOM_JAIL_NAME=.*|CUSTOM_JAIL_NAME=|\"${TMP_CUSTOM_JAIL_NAME}\"|" "${SCRIPTPATH}/jail.vars"
sed -i "" "s|CUSTOM_USE_PLEXPASS=.*|CUSTOM_USE_PLEXPASS=|\"${TMP_CUSTOM_USE_PLEXPASS}\"|" "${FVARS}"
sed -i "" "s|CUSTOM_USE_PLEXPASS=.*|CUSTOM_USE_PLEXPASS=|\"${TMP_CUSTOM_USE_PLEXPASS}\"|" "${SCRIPTPATH}/jail.vars"
sed -i "" "s|CUSTOM_BKP_DIR=.*|CUSTOM_BKP_DIR=\"${TMP_CUSTOM_BKP_DIR}\"|" "${FVARS}"
sed -i "" "s|CUSTOM_BKP_DIR=.*|CUSTOM_BKP_DIR=\"${TMP_CUSTOM_BKP_DIR}\"|" "${SCRIPTPATH}/jail.vars"