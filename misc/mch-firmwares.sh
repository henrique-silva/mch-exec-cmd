#!/usr/bin/env bash

############################
# MCH
############################
MCH_URL_RELEASE_BASE="ftp://ftp.nateurope.com"
MCH_FIRMWARE_VERSION="2_20_4"
MCH_FIRMWARE_EXTENSION=".bin"
MCH_FIRMWARE_NAME="mch_fw"

# MCH firmware full name
MCH_FIRMWARE="${MCH_FIRMWARE_NAME}${MCH_FIRMWARE_EXTENSION}"

# MCH firmware URL
URL_MCH_FIRMWARE=${MCH_URL_RELEASE_BASE}/${MCH_FIRMWARE}

############################
# All MCH firmares
############################
# Keep them synched!
URL_MCH_FIRMWARES_ALL=(${URL_MCH_FIRMWARE})
MCH_FIRMWARES_ALL=(${MCH_FIRMWARE})
