#!/usr/bin/env bash

DEBIAN_CODENAME=$(cat /etc/os-release | grep VERSION_CODENAME | cut -d "=" -f2)
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
  # (6.1 and up)
  sed -i "s|if (data.status !== 'Active')|if (false)|g" ${JSLIBFILE}
  # Anchor so we can safely replace what we want for multiline
  sed -i 's|res === null \|\| res === undefined \|\| \!res \|\| res|REPLACEME|' ${JSLIBFILE}
  # (6.2-11 and up)
  sed -i -z "s/REPLACEME.*.false/false/" ${JSLIBFILE}
  # (6.2-12 and up)
  sed -i -z "s/REPLACEME.*data.status !== 'Active'/false/" ${JSLIBFILE}
  # (6.2-15 6.3-2 6.3-3 6.3-4 6.3-6 and up)
  sed -i -z "s/REPLACEME.*.data.status.toLowerCase() !== 'active'/false/" ${JSLIBFILE}
  
}

pve_patch
