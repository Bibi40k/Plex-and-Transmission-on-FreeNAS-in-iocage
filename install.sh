#!/bin/bash
# Build Plex & Transmission Iocage Jail under FreeNAS


# Getting installer dir ( /root/Plex-and-Transmission-on-FreeNAS-in-Iocage )
SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "${SCRIPT}")


# Import scripts from /scripts dir
source ${SCRIPTPATH}/scripts/env.sh # few vars
source ${SCRIPTPATH}/scripts/dirs.sh # create all dir structure
source ${SCRIPTPATH}/scripts/files.sh # create/copy all files
source ${SCRIPTPATH}/scripts/defaults.sh # default vars & constants
source "${FVARS}" # custom vars we created in 'CUSTOM_BKP_DIR/jail.vars'

# Create jail with Custom vars
echo ""
echo "Jail creation in progress..."

iocage create \
    -n ${CUSTOM_JAIL_NAME} \
    ip4_addr="${CUSTOM_INTERFACE}|${CUSTOM_JAIL_IP}/24" \
    defaultrouter=${DEFAULT_GW_IP} \
    dhcp=${DHCP} \
    bpf=${BPF} \
    vnet=${VNET} \
    vnet_default_interface=${VNET_DEFAULT_INTERFACE} \
    boot=${BOOT} \
    allow_mount=${ALLOW_MOUNT} \
    allow_mount_devfs=${ALLOW_MOUNT_DEVFS} \
    allow_raw_sockets=${ALLOW_RAW_SOCKETS} \
    allow_tun=${ALLOW_TUN} \
    ip6_saddrsel=${IP6_SADDRSEL} \
    -r ${DEFAULT_RELEASE} \
    -p ${FPKG};
echo ""

iocage fstab -a ${CUSTOM_JAIL_NAME} "${CUSTOM_DOWNLOAD_DIR}" "/mnt/DOWNLOADS" nullfs rw 0 0