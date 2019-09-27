# pve-patch

Removes subscription dialogs, replaces enterprise repository with non-subscription repository and replaces branding. Tested on PVE 6.0-7.

## Note

Use at your own risk! Read the script before you run it. 

## Install

1. Connect to node via SSH
2. Run

```bash
# with sudo if not root
wget -qO - https://raw.githubusercontent.com/kosmonavtika/pve-patch/master/patch.sh | bash
```

## Restore

Enterprise repository

```
mv /etc/apt/sources.list.d/pve.list.bak /etc/apt/sources.list.d/pve.list.bak
```

Branding

```
cp -f /usr/share/pve-manager/images/{favicon.ico,logo-128.png,proxmox_logo.png}~ /usr/share/pve-patch/images/ && \
/usr/share/pve-patch/scripts/apply.sh
```
