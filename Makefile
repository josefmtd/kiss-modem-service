include .env

.PHONY: dependencies
dependencies:
		apt update
		apt upgrade -y
		apt install -y libax25-dev ax25-apps ax25-tools

.PHONY: install
install:
		cp ./src/conf/axports /etc/ax25/axports
		sed -i 's|$$CALLSIGN|'${CALLSIGN}'|g' /etc/ax25/axports
		sed -i 's|$$BAUDRATE|'${BAUDRATE}'|g' /etc/ax25/axports
		sed -i 's|$$PACLEN|'${PACLEN}'|g' /etc/ax25/axports
		sed -i 's|$$WINDOW|'${WINDOW}'|g' /etc/ax25/axports
		cp ./src/services/kiss-modem.service /etc/systemd/system/kiss-modem.service
		systemctl daemon-reload
		systemctl enable kiss-modem.service
		systemctl start kiss-modem.service
		cp ./src/udev/10-kissmodem.rules /etc/udev/rules.d/10-kissmodem.rules
		udevadm control --reload

