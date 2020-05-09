#!/bin/bash
# Requires: dirs.sh



function CheckOS {

    # Check for current FreeNAS version and set variables. 
    OS_VERSION=$(freebsd-version | sed "s/STABLE/RELEASE/g" | sed "s/-.*//g")
    FULL_OS_VERSION=$(freebsd-version)

    if (( $(echo "${OS_VERSION} < 11.2" | bc -l) )); then
        echo -e "Hi ${AUTO_USER}, ${COLOR_RED}only FreeNAS greater than 11.2 are confirmed to work.${COLOR_N}"
        echo -e "${INFO} If you get any errors you can share them and i'll try to help you."
        echo -e "${INFO} Please forward your feedback. We continue in few seconds."
        sleep 5
    fi

}

CheckOS

