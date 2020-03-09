#!/bin/bash


# Create jail with Custom vars
echo ""
echo "Jail creation in progress..."
echo ""

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
    -p "${FPKG}";
echo ""

MEDIA_GROUP=$(id -g media) # media user group id on FreeNAS (should be 8675309)

iocage exec ${CUSTOM_JAIL_NAME} "env ASSUME_ALWAYS_YES=YES pkg bootstrap"
iocage exec ${CUSTOM_JAIL_NAME} "mkdir -p /mnt/DOWNLOADS"




# Users & groups ( > /dev/null 2>&1 silents all messages )
iocage exec "${CUSTOM_JAIL_NAME}" "getent group | cut -d':' -f1,3-4 | grep -E 'media|ftp'"
echo ""
iocage exec "${CUSTOM_JAIL_NAME}" "/bin/sh -c 'if [ ! `id -u media` ]; then pw useradd -n media -w none -u ${MEDIA_GROUP} -G ftp -c \"Media User\"; fi'"
# iocage exec "${CUSTOM_JAIL_NAME}" "pw useradd -n media -w none -u ${MEDIA_GROUP} -G ftp -c 'Media User'"
echo ""
iocage exec "${CUSTOM_JAIL_NAME}" "getent group | cut -d':' -f1,3-4 | grep -E 'media|ftp'"
echo ""
iocage exec "${CUSTOM_JAIL_NAME}" "id media"
echo ""
iocage fstab -a ${CUSTOM_JAIL_NAME} "${CUSTOM_DOWNLOAD_DIR}" "/mnt/DOWNLOADS" nullfs rw 0 0

