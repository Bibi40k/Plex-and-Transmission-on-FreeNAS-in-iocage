#!/bin/bash
# This script will create all necessary dirs & store them in vars




# Create dirs, copy dummy vars file and set bkp dir
# DIRS=("${TMP_CUSTOM_BKP_DIR}"/"${TMP_CUSTOM_JAIL_NAME}"/{plexdata,transmission-config})
# mkdir -p -- "${DIRS[@]}"


### DIRS ###
# DBKP="${TMP_CUSTOM_BKP_DIR}/${TMP_CUSTOM_JAIL_NAME}"
# DPLEXDATA="${DBKP}/plexdata"
# DTRANSMISSION="${DBKP}/transmission-config"
# DDOWNLOAD="/mnt/${POOL_NAME}/FTP"





### DIRS ###
DCONFIG="${DIR}/mediabox-configs"   # Custom configs dir
DBACKUP="${DIR}/backup"             # Custom backup dir
DAPPS="${DCONFIG}/apps"             # Apps configs dir
DLOGS="${DCONFIG}/logs"             # Logs dir



function CheckConfigDirs {
   
    # Create config dir(s) if doesn't exist(s) already
    # We check for the '/apps/originals' because we always keep customizations
    echo -ne "${PROGRESS} checking config dirs... "
    if [[ ! -d "${DCONFIG}/apps/plex/originals" ]] ; then
        echo -e "${WARNING} no config dirs found"
        DIRS=(${DCONFIG}/{apps/{plex/originals,transmission/originals},logs/originals})
        
        echo -ne "${PROGRESS} creating config dirs to ${DCONFIG}... "
        if mkdir -p -- "${DIRS[@]}"; then
            echo -e "${OK}"
        else
            echo -e "${FAIL}"
        fi
    else
        echo -e "${OK}"
    fi

}


echo
CheckConfigDirs

