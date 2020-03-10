#!/bin/sh

#write out current crontab
iocage exec ${CUSTOM_JAIL_NAME} "crontab -l > mycron"
if [ $CUSTOM_USE_PLEXPASS == "yes" ]; then
    iocage exec ${CUSTOM_JAIL_NAME} echo "18 3 * * 0 pkg upgrade -y && service plexmediaserver-plexpass restart" >> mycron
else
    iocage exec ${CUSTOM_JAIL_NAME} echo "18 3 * * 0 pkg upgrade -y && service plexmediaserver restart" >> mycron
fi

while read LINE || [[ -n "$LINE" ]]; do
    # We first delete previous cronjob
    iocage exec ${CUSTOM_JAIL_NAME} crontab -l 2>/dev/null | sed -e "\?^plexmediaserver\$?,/^\$/ d" | crontab -
    # We add cronjob
    iocage exec ${CUSTOM_JAIL_NAME} crontab -l | grep "$LINE" || (crontab -l 2>/dev/null; echo "$LINE") | crontab -
done < mycron

iocage exec ${CUSTOM_JAIL_NAME} echo "mycron is " mycron
iocage exec ${CUSTOM_JAIL_NAME} rm mycron