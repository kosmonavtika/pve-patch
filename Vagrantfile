# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "pve-patch"
  config.vm.box = "proxmox-ve-amd64"
  config.vm.network "private_network", ip: "10.91.0.10"
  config.vm.provision "shell", path: "https://raw.githubusercontent.com/kosmonavtika/pve-patch/master/patch.sh"
end
