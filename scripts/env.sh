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

# Now, that we have all we need we can create Bkp dir and copy 'dummy-jail.vars'
DBKP="${TMP_CUSTOM_BKP_DIR}/${TMP_CUSTOM_JAIL_NAME}"
mkdir -p "${DBKP}"
\cp -n "${SCRIPTPATH}/src/dummy-jail.vars" "${DBKP}/jail.vars"
FVARS="${DBKP}/jail.vars"

sed -i "" "s|CUSTOM_JAIL_NAME=.*|CUSTOM_JAIL_NAME=\"${TMP_CUSTOM_JAIL_NAME}\"|" "${FVARS}"
sed -i "" "s|CUSTOM_JAIL_NAME=.*|CUSTOM_JAIL_NAME=\"${TMP_CUSTOM_JAIL_NAME}\"|" "${SCRIPTPATH}/jail.vars"
sed -i "" "s|CUSTOM_BKP_DIR=.*|CUSTOM_BKP_DIR=\"${TMP_CUSTOM_BKP_DIR}\"|" "${FVARS}"
sed -i "" "s|CUSTOM_BKP_DIR=.*|CUSTOM_BKP_DIR=\"${TMP_CUSTOM_BKP_DIR}\"|" "${SCRIPTPATH}/jail.vars"

