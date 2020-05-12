#!/bin/bash
# Transmission configuration



echo -e "${INFO} Starting Transmission configuration..."
  iocage exec ${JAIL_NAME} "chown -R media:ftp /usr/local/etc/transmission"
  iocage exec ${JAIL_NAME} "sysrc transmission_enable=YES"
  iocage exec ${JAIL_NAME} "sysrc transmission_user=media"
  iocage exec ${JAIL_NAME} "service transmission start"

