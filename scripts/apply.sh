#!/usr/bin/env bash

DEBIAN_CODENAME=`cat /etc/os-release | grep VERSION_CODENAME | cut -d "=" -f2`
ENTERPRISE_REPO_LIST="/etc/apt/sources.list.d/pve-enterprise.list"
FREE_REPO_FILE="/etc/apt/sources.list.d/pve.list"
FREE_REPO_LIST=$(cat <<-EOF
# PVE pve-no-subscription repository provided by proxmox.com,
# NOT recommended for production use
deb http://download.proxmox.com/debian/pve ${DEBIAN_CODENAME} pve-no-subscription
EOF
)
JSLIBFILE="/usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js"

function pve_patch() {
  echo "- apply patch..."
  echo "$FREE_REPO_LIST" > $FREE_REPO_FILE
  [ -f $ENTERPRISE_REPO_LIST ] && mv $ENTERPRISE_REPO_LIST $ENTERPRISE_REPO_LIST~
  grep -iq "data.status[^ ]* !== 'Active'" $JSLIBFILE &&
    sed -i.bak -z "s/if ([^{]*data.status[^ ]* !== 'active'[^{]*) {/if (false) {/gi" $JSLIBFILE
}

pve_patch