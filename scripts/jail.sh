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
JAIL_ROOT="/mnt/${POOL_NAME}/iocage/jails/${CUSTOM_JAIL_NAME}/root"

iocage exec ${CUSTOM_JAIL_NAME} "env ASSUME_ALWAYS_YES=YES pkg bootstrap"
mkdir -p "${JAIL_ROOT}/mnt/DOWNLOADS"
mkdir -p "${JAIL_ROOT}/usr/local/etc/pkg/repos"
\cp -n "${JAIL_ROOT}/etc/pkg/FreeBSD.conf" "${JAIL_ROOT}/usr/local/etc/pkg/repos/"
sed -i "" "s|quarterly|latest|" "${JAIL_ROOT}/usr/local/etc/pkg/repos/FreeBSD.conf"

# iocage exec ${CUSTOM_JAIL_NAME} "mkdir -p /mnt/DOWNLOADS"
# iocage exec ${CUSTOM_JAIL_NAME} "mkdir -p /usr/local/etc/pkg/repos"
# iocage exec ${CUSTOM_JAIL_NAME} "\cp -n /etc/pkg/FreeBSD.conf /usr/local/etc/pkg/repos/"
# iocage exec ${CUSTOM_JAIL_NAME} "sed -i '' 's|quarterly|latest|' /usr/local/etc/pkg/repos/FreeBSD.conf"



# Users & groups
iocage exec "${CUSTOM_JAIL_NAME}" /bin/sh -c "if ! id -u media >/dev/null 2>&1; then pw useradd -n media -w none -u ${MEDIA_GROUP} -G ftp -c 'Media User'; fi"
echo ""
iocage fstab -a ${CUSTOM_JAIL_NAME} "${CUSTOM_DOWNLOAD_DIR}" "/mnt/DOWNLOADS" nullfs rw 0 0

