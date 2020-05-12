#!/bin/bash
# This script will create/copy all necessary files for jailbox
# Destination folder is '/mnt/ZFS_NAME/iocage/jails/${JAIL_NAME}/root/...'



# Get iocage path (accessible from FreeNAS)
IOCAGE_PATH=$(zfs list -o name,mountpoint | grep -m1 iocage/jails/${JAIL_NAME} | awk '{print $2;}')

JAIL_DCONFIG="/root/mediabox-configs" # Custom configs dir inside jail
JAIL_DBACKUP="/root/backup" # Custom backup dir inside jail
JAIL_DAPPS="${JAIL_DCONFIG}/apps" # Server configs dir inside jail
JAIL_DLOGS="${JAIL_DCONFIG}/logs" # Logs dir inside jail

