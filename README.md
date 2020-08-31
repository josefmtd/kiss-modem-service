# kiss-modem-service

KISS Modem Service with UDEV

## Introduction

This service is a systemd service that uses Linux AX.25 interface that is initialized by `kissattach` that is available from `libax25-dev` and `ax25-tools`

## Installation

Install Git and clone the repository

```
# apt update
# apt install git -y
$ git clone https://github.com/josefmtd/kiss-modem-service
```

Configure the environment and replace the callsign with your amateur radio callsign, also replace baudrate, packet length, and maximum window length with appropriate values

```
$ nano .env
```

Install all dependencies and the service

```
# make install
```

Reconfigure the callsign, baudrate, packet length, and maximum window length by re-editting `.env` and use the following command afterwards

```
# make reconfigure
```
