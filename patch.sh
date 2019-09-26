#!/usr/bin/env bash

sudo mkdir -p /usr/share/pve-patch/{images,scripts} && \
echo "- patch `pveversion`..." && \
echo "- download and copy files..." && \
sudo wget -qP /usr/share/pve-patch/images/ https://github.com/kosmonavtika/pve-patch/raw/master/images/{favicon.ico,logo-128.png,proxmox_logo.png} && \
sudo wget -qP /usr/share/pve-patch/scripts/ https://raw.githubusercontent.com/kosmonavtika/pve-patch/master/scripts/{90pvepatch,apply.sh} && \
sudo chmod -R a+x /usr/share/pve-patch/scripts && \
sudo cp -f /usr/share/pve-patch/scripts/90pvepatch /etc/apt/apt.conf.d/90pvepatch && \
echo "- apply patch..." && \
sudo /usr/share/pve-patch/scripts/apply.sh && \
echo "- done!"
