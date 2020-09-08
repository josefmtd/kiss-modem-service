include .env

.PHONY: dependencies
dependencies:
		apt update
		apt upgrade -y
		apt install -y libax25-dev ax25-tools

.PHONY: configure
configure:
		cp ./src/conf/axports /etc/ax25/axports
		sed -i 's|$$CALLSIGN|'${CALLSIGN}'|g' /etc/ax25/axports
		sed -i 's|$$BAUDRATE|'${BAUDRATE}'|g' /etc/ax25/axports
		sed -i 's|$$PACLEN|'${PACLEN}'|g' /etc/ax25/axports
		sed -i 's|$$WINDOW|'${WINDOW}'|g' /etc/ax25/axports

.PHONY: reconfigure
reconfigure: configure restart-service

.PHONY: restart-service
restart-service:
		systemctl restart kiss-modem.service

.PHONY: install
install: dependencies configure install-service

.PHONY: install-service
install-service:
		cp ./src/services/kiss-modem.service /etc/systemd/system/kiss-modem.service
		cp ./src/udev/10-kissmodem.rules /etc/udev/rules.d/10-kissmodem.rules
		udevadm control --reload
		systemctl daemon-reload
		systemctl enable kiss-modem.service
		systemctl restart kiss-modem.service
