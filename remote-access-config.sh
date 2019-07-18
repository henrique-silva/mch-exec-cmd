#!/bin/bash

set -euo pipefail

SCRIPTPATH="$( cd "$( dirname "${BASH_SOURCE[0]}"  )" && pwd  )"

# Source misc functions
. ${SCRIPTPATH}/misc/functions.sh

. ${SCRIPTPATH}/misc/mch-firmwares.sh

if [ $# -eq 1 ]; then
    TFTP_FILE="$1"
    TFTP_IPADDR="0.0.0.0"
elif [ $# -eq 2 ]; then
    TFTP_FILE="$1"
    TFTP_IPADDR="$2"
else
    echo 'Usage:'
    echo '$0 <tftp file> <tftp server address>'
    echo '$0 <tftp file> (TFTP server address defaults to 0.0.0.0)'
    exit 1
fi

# Check if we already have the packages
if ! [[ $(which expect) ]] || ! [[ $(which tftp) ]] || ! [ -f /etc/default/tftpd-hpa ]; then
    UPDATE_CMD="apt-get update"
fi

PACKS=()
INSTALL_CMD="apt-get install -y"
# Install each one of the missing ones
if ! [[ $(which expect) ]] ; then
    PACKS+=("expect")
fi

if ! [[ $(which tftp) ]] ; then
    PACKS+=("tftp")
fi

if ! [ -f /etc/default/tftpd-hpa ]; then
    PACKS+=("tftpd-hpa")
fi

# Update cache if needed
if [ -v UPDATE_CMD ]; then
    exec_cmd "TRACE" echo "Updating cache..."
    sudo ${UPDATE_CMD}
    exec_cmd "TRACE" echo "Success!"
fi

# Install packages if needed
if [ -v PACKS ]; then
    exec_cmd "TRACE" echo "Installing needed packages..."
    sudo ${INSTALL_CMD} "${PACKS[@]}"
    exec_cmd "TRACE" echo "Success!"
fi

exec_cmd "TRACE" echo "Setting up the TFTP server..."
sudo sed -i 's/\":69\"/\"${TFTP_IPADDR}:69\"/' /etc/default/tftpd-hpa
source /etc/default/tftpd-hpa
# Copy MCH firmware update
sudo cp ${TFTP_FILE} ${TFTP_DIRECTORY}
sudo service tftpd-hpa restart
exec_cmd "TRACE" echo "Success!"

exec_cmd "TRACE" echo "Testing if the TFTP server is up..."
tftp ${TFTP_IPADDR} << EOF
get ${TFTP_FILE} test_ftp
quit
EOF

if [ -e test_ftp ]
then
    if cmp -s "test_ftp" ${TFTP_FILE}
    then
        exec_cmd "INFO " echo "TFTP transfer was successful!"
    fi
    rm test_ftp
else
    exec_cmd "ERR  " echo "TFTP transfer failed!"
fi

exec_cmd "INFO " echo "TFTP successfully configured"
