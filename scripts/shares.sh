#!/bin/bash
# This script will join & map all shares



# Add all elements to SHARES
$(printf "\"%s\" " "${SHARES[@]}")
echo
SHARES+=("${MEDIA_DOWNLOAD_PATH}")
$(printf "\"%s\" " "${SHARES[@]}")
echo
SHARES+=("${MEDIA_BKP_PATH}/plexdata")
$(printf "\"%s\" " "${SHARES[@]}")
echo
SHARES+=("${MEDIA_BKP_PATH}/transmission-config")
$(printf "\"%s\" " "${SHARES[@]}")
echo

function MapShares {
    echo
    for SHARE in "${SHARES[@]}"; do
        echo -ne "${PROGRESS} map $SHARE to ${JAIL_NAME}... "
        if iocage fstab -a ${JAIL_NAME} "${SHARE}" "/mnt/${SHARE}" nullfs rw 0 0; then
            echo -e "${OK}"
        else
            echo -e "${FAIL}"
        fi
    done

}

