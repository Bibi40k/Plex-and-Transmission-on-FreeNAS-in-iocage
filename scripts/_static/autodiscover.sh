#!/bin/bash
# Autodiscover few variables for further use



AUTO_USER=$(who am i | awk '{print $1}')
AUTO_GW_IP=$(netstat -rn | grep -E "UGS[^A-Z]" | awk '{print $2;}')
SUGGESTED_LAST_OCTET_OF_IP="67" # no checks for this
AUTO_JAIL_IP=$(awk -F"." '{print $1"."$2"."$3".'${SUGGESTED_LAST_OCTET_OF_IP}'"}'<<<${AUTO_GW_IP})
AUTO_RELEASE=$(freebsd-version | sed "s/STABLE/RELEASE/g" | sed "s/-p.*//g")
AUTO_EXT_IP=$(dig @resolver1.opendns.com ANY myip.opendns.com +short)
AUTO_IP_RANGE=$(netstat -rn | grep -E "U[^A-Z]" | grep -v lo0 | awk '{print $1;}' | sed "s/\/.*//g") # 192.168.1.0
ZPOOL_NAME=$(iocage get -p)
ZPOOL_PATH="/mnt/${ZPOOL_NAME}/"
# ZPOOL_NAME=$(mount | grep /mnt/*/iocage/jails | head -n 1 | sed -e 's/.*\/mnt\/\(.*\)\/iocage\/jails.*/\1/')

