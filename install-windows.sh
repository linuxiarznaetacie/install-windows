#!/bin/bash

# Copyright (c) 2025 Jakub Orłowski
# Licensed under the MIT License. See LICENSE for details.

read -p "Wpisz ilosc pamieci RAM dla Windows (domyslnie: 4G): " RAM
RAM=${RAM:-4G}

read -p "Wpisz ilosc rdzeni przydzielonych dla Windows (domyslnie: 4): " CORES
CORES=${CORES:-4}

read -p "Wpisz pojemnosc dysku, ktora przydzielic dla Windows (domyslnie: 40G): " DISK_SIZE
DISK_SIZE=${DISK_SIZE:-40G}

read -p "Wklej direct download link do iso systemu (domyslnie: WINDOWS 10): " VERSION
VERSION=${VERSION:-https://nc01.winiso.pl/public.php/dav/files/jbqZRPBnF6PsH3T}

read -p "Wpisz port do NoVNC. Lepiej nie ruszac :) (domyslnie: 8006): " PORT
PORT=${PORT:-8006}

MY_IP=$(hostname -I | awk '{print $1}')
clear
echo "+------------------------------------------------------------+"
echo "Zarzadzaj swoim systemem z tego linku: http://$MY_IP:$PORT"
echo "Nie zapomnij otworzyc portu $PORT HTTP (TCP)"
echo "+------------------------------------------------------------+"
cat <<EOF > compose.yml
services:
  windows:
    image: dockurr/windows
    container_name: windows
    environment:
      RAM_SIZE: "$RAM"
      CPU_CORES: "$CORES"
      VERSION: "$VERSION"
      DISK_SIZE: "$DISK_SIZE"
      MANUAL: "Y"
    devices:
      - /dev/kvm
      - /dev/net/tun
    cap_add:
      - NET_ADMIN
    ports:
      - $PORT:$PORT
      - 3389:3389/tcp
      - 3389:3389/udp
    volumes:
      - ./windows:/storage
    restart: always
    stop_grace_period: 2m
EOF

docker compose up
clear
