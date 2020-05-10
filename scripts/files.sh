#!/bin/bash
# This script will create/copy all necessary files



### FILES ###
FVARS="${DCONFIG}/mediabox-install.cfg" # My custom vars file
FLOG="${DCONFIG}/mediabox-install.log" # Log file



function CheckConfigFile {
   
    # Create config dir(s) if doesn't exist(s) already
    # Use default vars file if i don't find a custom one yet
    echo -ne "${PROGRESS} checking config file... "
    if [[ ! -f "${FVARS}" ]] ; then
        echo -e "${WARNING} no config file found"
        
        echo -ne "${PROGRESS} copy 'sample-mediabox-install.cfg' to ${FVARS}... "
        if \cp -n "$DIR/src/sample-mediabox-install.cfg" "${FVARS}"; then
            echo -e "${OK}"
        else
            echo -e "${FAIL}"
        fi
    else
        echo -e "${OK}"
    fi

}

CheckConfigFile
echo

