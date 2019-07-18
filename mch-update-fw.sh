#!/usr/bin/env bash

SCRIPTPATH="$( cd "$( dirname "${BASH_SOURCE[0]}"  )" && pwd  )"

# Source misc functions
. ${SCRIPTPATH}/misc/functions.sh

# Simple argument checking
if [ $# -lt 3 ]; then
    echo "Usage: ./mch-update-fw.sh <MCH Password> <TFTP server address> <TFTP file to transfer>"
    exit 1
fi

# MCH config arguments
MCH_PASS="$1"
TFTP_ADDR="$2"
TFTP_FILE="$3"

# Configure TFTP server
. ${SCRIPTPATH}/remote-access-config.sh $TFTP_FILE $TFTP_ADDR

# Execute the firmware update script on all MCHs
. ${SCRIPTPATH}/mch-exec-cmd-all.sh $MCH_PASS ${SCRIPTPATH}/exp_scripts/update-mch-cfg.exp $TFTP_ADDR $TFTP_FILE

# Disable TFTP service
sudo service tftpd-hpa stop
