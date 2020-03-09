#!/bin/bash


iocage exec ${CUSTOM_JAIL_NAME} "mkdir -p /mnt/plexdata"
iocage exec ${CUSTOM_JAIL_NAME} "chown -R media:ftp /mnt/plexdata"
iocage fstab -a ${CUSTOM_JAIL_NAME} "${DPLEXDATA}" "/mnt/plexdata" nullfs rw 0 0


if [ $CUSTOM_USE_PLEXPASS == "yes" ]; then
  echo ""
  iocage exec ${CUSTOM_JAIL_NAME} "sysrc plexmediaserver_plexpass_enable='YES'"
  iocage exec ${CUSTOM_JAIL_NAME} "sysrc plexmediaserver_plexpass_support_path='/mnt/plexdata'"
  iocage exec ${CUSTOM_JAIL_NAME} "sysrc plexmediaserver_plexpass_user='media'"
  iocage exec ${CUSTOM_JAIL_NAME} "sysrc plexmediaserver_plexpass_group='ftp'"
else
  echo ""
  iocage exec ${CUSTOM_JAIL_NAME} "sysrc plexmediaserver_enable='YES'"
  iocage exec ${CUSTOM_JAIL_NAME} "sysrc plexmediaserver_support_path='/mnt/plexdata'"
  iocage exec ${CUSTOM_JAIL_NAME} "sysrc plexmediaserver_user='media'"
  iocage exec ${CUSTOM_JAIL_NAME} "sysrc plexmediaserver_group='ftp'"
fi



# Install WebTools.bundle
echo ""
iocage exec ${CUSTOM_JAIL_NAME} "wget https://github.com/ukdtom/WebTools.bundle/releases/download/3.0.0/WebTools.bundle.zip -P ${DPLEXDATA}/Plex\ Media\ Server/Plug-ins"
iocage exec ${CUSTOM_JAIL_NAME} "unzip ${DPLEXDATA}/Plex\ Media\ Server/Plug-ins/WebTools.bundle.zip"
iocage exec ${CUSTOM_JAIL_NAME} "rm ${DPLEXDATA}/Plex\ Media\ Server/Plug-ins/WebTools.bundle.zip"
iocage exec ${CUSTOM_JAIL_NAME} "chown -R media:ftp ${DPLEXDATA}/Plex\ Media\ Server/Plug-ins/WebTools.bundle"
# iocage exec ${CUSTOM_JAIL_NAME} "service plexmediaserver restart"

