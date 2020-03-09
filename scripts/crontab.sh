#!/bin/sh

#write out current crontab
crontab -l > mycron
if [ $CUSTOM_USE_PLEXPASS == "yes" ]; then
    echo "18 3 * * 0 pkg upgrade -y && service plexmediaserver-plexpass restart" >> mycron
else
    echo "18 3 * * 0 pkg upgrade -y && service plexmediaserver restart" >> mycron
fi

while read LINE || [[ -n "$LINE" ]]; do
    # We first delete previous cronjob
    crontab -l 2>/dev/null | sed -e "\?^plexmediaserver\$?,/^\$/ d" | crontab -
    # We add cronjob
    crontab -l | grep "$LINE" || (crontab -l 2>/dev/null; echo "$LINE") | crontab -
done < mycron

rm mycron