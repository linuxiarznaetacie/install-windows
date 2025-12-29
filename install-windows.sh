#!/bin/bash    

# +------------------------------------------------------------+
# W10-AUTOINSTALL
# AUTORSTWA: Qwertyk12345
# GITHUB: https://github.com/@gownokutas
# DISCORD: hbfghfgh_24146
# TELEGRAM: https://t.me/pomocinformatyczn
# LINK DO ORYGINALNEGO PROJEKTU: https://github.com/dockur/windows
# +------------------------------------------------------------+
# NIE ZEZWALAM NA USUNIĘCIE TEGO WATERMARKA ANI MONETYZOWANIE
# MOJEJ PRACY BEZ MOJEJ ZGODY!
# +------------------------------------------------------------+
MY_IP=$(hostname -I | awk '{print $1}')
echo "+------------------------------------------------------------+"
echo "Zarzadzaj swoim systemem z tego linku: http://$MY_IP:8006"
echo "Nie zapomnij otworzyc portu 8006 HTTP (TCP)"
echo "+------------------------------------------------------------+"
cat <<EOF > compose.yml
services:
  windows:
    image: dockurr/windows
    container_name: windows
    environment:
      RAM_SIZE: "64G"
      CPU_CORES: "32"
      VERSION: "10"
      DISK_SIZE: "2048G"
      MANUAL: "Y"
    devices:
      - /dev/kvm
      - /dev/net/tun
    cap_add:
      - NET_ADMIN
    ports:
      - 8006:8006
      - 3389:3389/tcp
      - 3389:3389/udp
    volumes:
      - ./windows:/storage
    restart: always
    stop_grace_period: 2m
EOF

docker compose up
clear
