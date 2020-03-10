#!/bin/sh

#write out current crontab
iocage exec ${CUSTOM_JAIL_NAME} "crontab -l > /tmp/mycron"
if [ $CUSTOM_USE_PLEXPASS == "yes" ]; then
    iocage exec ${CUSTOM_JAIL_NAME} echo "18 3 * * 0 pkg upgrade -y && service plexmediaserver-plexpass restart" >> /tmp/mycron
else
    iocage exec ${CUSTOM_JAIL_NAME} echo "18 3 * * 0 pkg upgrade -y && service plexmediaserver restart" >> /tmp/mycron
fi

while read LINE || [[ -n "$LINE" ]]; do
    # We first delete previous cronjob
    iocage exec ${CUSTOM_JAIL_NAME} crontab -l 2>/dev/null | sed -e "\?^plexmediaserver\$?,/^\$/ d" | crontab -
    # We add cronjob
    iocage exec ${CUSTOM_JAIL_NAME} crontab -l | grep "$LINE" || (crontab -l 2>/dev/null; echo "$LINE") | crontab -
done < /tmp/mycron

iocage exec ${CUSTOM_JAIL_NAME} echo "mycron is " /tmp/mycron
# iocage exec ${CUSTOM_JAIL_NAME} rm mycron