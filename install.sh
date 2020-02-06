#!/bin/bash

DIR=`dirname $0`

# Get the configuration from kiss.conf
source "${DIR}/kiss.conf"

# Install the dependencies
/usr/bin/apt update
/usr/bin/apt -y upgrade

/usr/bin/apt install libax25-dev ax25-apps ax25-tools

# Copy the axports
/bin/cp "${DIR}/src/conf/axports" /etc/ax25/axports
sed -i 's|$CALLSIGN|'$CALLSIGN'|g' /etc/ax25/axports
sed -i 's|$BAUDRATE|'$BAUDRATE'|g' /etc/ax25/axports
sed -i 's|$PACLEN|'$PACLEN'|g' /etc/ax25/axports
sed -i 's|$WINDOW|'$WINDOW'|g' /etc/ax25/axports

# Install the service
/bin/cp "${DIR}/src/services/kiss-modem.service" /etc/systemd/system/kiss-modem.service
/bin/systemctl daemon-reload
/bin/systemctl enable kiss-modem.service

# Install the udev rules
/bin/cp "${DIR}/src/udev/10-kissmodem.rules" /etc/udev/rules.d/10-kissmodem.rules
/sbin/udevadm control --reload

# Restart the system
/bin/sleep 5
/bin/systemctl reboot
