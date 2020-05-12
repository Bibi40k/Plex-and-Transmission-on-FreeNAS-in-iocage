#!/bin/bash
# This script will create 'Media User' inside Jailbox and add it to ftp group


echo -e "${INFO} ADDING MEDIA USER"
echo -ne "${PROGRESS} Checking ID & GROUP for ftp & media users within FreeNAS box... "
    getent passwd | cut -d':' -f1,3-4 | grep -E 'media|ftp'
    FTPUSER_GROUP=$(id -g ftp)
    MEDIAUSER_GROUP=$(id -g media)
echo -e "${OK}"

echo -ne "${PROGRESS} Checking curent values within Jailbox... "
    iocage exec ${JAIL_NAME} getent group | cut -d':' -f1,3-4 | grep -E 'media|ftp'
echo -ne "${PROGRESS} Add 'Media User' inside Jailbox and add it to ftp group... "
    iocage exec ${JAIL_NAME} pw useradd -n media -w none -u ${MEDIAUSER_GROUP} -G ftp -c "Media User"
echo -ne "${PROGRESS} Rechecking curent values within Jailbox... "
    iocage exec ${JAIL_NAME} getent group | cut -d':' -f1,3-4 | grep -E 'media|ftp'
    iocage exec ${JAIL_NAME} id media

