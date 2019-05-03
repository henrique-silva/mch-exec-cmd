#!/usr/bin/env bash

SCRIPTPATH="$( cd "$( dirname "${BASH_SOURCE[0]}"  )" && pwd  )"

# Source misc functions
. ${SCRIPTPATH}/misc/functions.sh

# Simple argument checking
if [ $# -lt 2 ]; then
    echo "Usage: ./mch-update-fw.sh <MCH Password> <TFTP server address>"
    exit 1
fi

# MCH config arguments
MCH_PASS="$1"
TFTP_ADDR="$2"

# Configure TFTP server
. ${SCRIPTPATH}/remote-access-config.sh $TFTP_ADDR

# Execute the firmware update script on all MCHs
. ${SCRIPTPATH}/mch-exec-cmd-all.sh $MCH_PASS ${SCRIPTPATH}/exp_scripts/update-mch-fw.exp $TFTP_ADDR

# Disable TFTP service
sudo service tftpd-hpa stop
