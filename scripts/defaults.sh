#!/bin/bash



# Default iocage vars
DEFAULT_JAIL_NAME="MediaBox"
DEFAULT_INTERFACE="vnet0"
DEFAULT_GW_IP=$(netstat -rn | grep -E "UGS[^A-Z]" | awk '{print $2;}')
DEFAULT_LAST_OCTET_OF_IP="77" # no checks for this
DEFAULT_JAIL_IP="$(awk -F"." '{print $1"."$2"."$3".'${DEFAULT_LAST_OCTET_OF_IP}'"}'<<<${DEFAULT_GW_IP})"
DEFAULT_RELEASE=$(freebsd-version | sed "s/STABLE/RELEASE/g" | sed "s/-p.*//g")



# Used for Clients config file
EXT_IP=$(dig @resolver1.opendns.com ANY myip.opendns.com +short)
DEFAULT_EXT_PORT="1194"



# Params for jail creation
VNET="on"
VNET_DEFAULT_INTERFACE="none"
DHCP="off"
BPF="yes"
BOOT="on"
ALLOW_MOUNT="on"
ALLOW_MOUNT_DEVFS="on"
ALLOW_RAW_SOCKETS="1"
ALLOW_TUN="1"
IP6_SADDRSEL="1"



# Params for OpenVPN configuration
# IP_RANGE = 192.168.1.0
IP_RANGE=$(netstat -rn | grep -E "U[^A-Z]" | grep -v lo0 | awk '{print $1;}' | sed "s/\/.*//g")



source ${FVARS} # custom vars we created in '~/openvpn-configs/jail.vars'



# $CUSTOM_JAIL_NAME
echo ""
if [ ! -z $CUSTOM_JAIL_NAME ]; then
  read -p "We already set Iocage Name as [${CUSTOM_JAIL_NAME}]: " TMP_CUSTOM_JAIL_NAME
  TMP_CUSTOM_JAIL_NAME=${TMP_CUSTOM_JAIL_NAME:-$CUSTOM_JAIL_NAME}
else
  read -p "Iocage name not set, default Name is [${DEFAULT_JAIL_NAME}]: " TMP_CUSTOM_JAIL_NAME
  TMP_CUSTOM_JAIL_NAME=${TMP_CUSTOM_JAIL_NAME:-$DEFAULT_JAIL_NAME}
fi
sed -i "" "s/CUSTOM_JAIL_NAME=.*/CUSTOM_JAIL_NAME=\"${TMP_CUSTOM_JAIL_NAME}\"/" ${FVARS}



# $CUSTOM_JAIL_IP
if [ ! -z "$CUSTOM_JAIL_IP" ]; then
  read -p "We already set Iocage IP as [${CUSTOM_JAIL_IP}]: " TMP_CUSTOM_JAIL_IP
  TMP_CUSTOM_JAIL_IP=${TMP_CUSTOM_JAIL_IP:-$CUSTOM_JAIL_IP}
else
  read -p "Jail IP not set, default is [${DEFAULT_JAIL_IP}]: " TMP_CUSTOM_JAIL_IP
  TMP_CUSTOM_JAIL_IP=${TMP_CUSTOM_JAIL_IP:-$DEFAULT_JAIL_IP}
fi
sed -i "" "s/CUSTOM_JAIL_IP=.*/CUSTOM_JAIL_IP=\"${TMP_CUSTOM_JAIL_IP}\"/" ${FVARS}



# $CUSTOM_EXT_PORT
if [ ! -z "$CUSTOM_EXT_PORT" ]; then
  read -p "We already set External PORT as [${CUSTOM_EXT_PORT}]: " TMP_CUSTOM_EXT_PORT
  TMP_CUSTOM_EXT_PORT=${TMP_CUSTOM_EXT_PORT:-$CUSTOM_EXT_PORT}
else
  read -p "External PORT not set, default is [${DEFAULT_EXT_PORT}]: " TMP_CUSTOM_EXT_PORT
  TMP_CUSTOM_EXT_PORT=${TMP_CUSTOM_EXT_PORT:-$DEFAULT_EXT_PORT}
fi
sed -i "" "s/CUSTOM_EXT_PORT=.*/CUSTOM_EXT_PORT=\"${TMP_CUSTOM_EXT_PORT}\"/" ${FVARS}



# $CUSTOM_INTERFACE
if [ ! -z "$CUSTOM_INTERFACE" ]; then
  read -p "We already set Interface Name as [${CUSTOM_INTERFACE}]: " TMP_CUSTOM_INTERFACE
  TMP_CUSTOM_INTERFACE=${TMP_CUSTOM_INTERFACE:-$CUSTOM_INTERFACE}
else
  read -p "Interface name not set, default is [${DEFAULT_INTERFACE}]: " TMP_CUSTOM_INTERFACE
  TMP_CUSTOM_INTERFACE=${TMP_CUSTOM_INTERFACE:-$DEFAULT_INTERFACE}
fi
sed -i "" "s/CUSTOM_INTERFACE=.*/CUSTOM_INTERFACE=\"${TMP_CUSTOM_INTERFACE}\"/" ${FVARS}

