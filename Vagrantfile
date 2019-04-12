# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Ubuntu 16.04
  server_os = "ubuntu/xenial64"
  # Ubuntu 18.04
  #server_os = "ubuntu/bionic64"
  # FreeBSD 11.2
  #server_os = "bento/freebsd-11.2"

  # We don't need the standard shared folder, so disable it
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.define "server" do |server|
    server.vm.box = "#{server_os}"
    server.vm.hostname = "salt-testing"
    server.vm.network "private_network", ip: "10.10.10.10"

    # Share the salt states into the VM to act as a server
    # FreeBSD guests require NFS options
    server.vm.synced_folder "states", "/srv/states"
    server.vm.synced_folder "pillar", "/srv/pillar"
    #server.vm.synced_folder "states", "/srv/states",
    #    nfs: true,
    #    nfs_udp: false,
    #    mount_options: ['nfsv3,vers=3,noatime']
    #server.vm.synced_folder "pillar", "/srv/pillar",
    #    nfs: true,
    #    nfs_udp: false,
    #    mount_options: ['nfsv3,vers=3,noatime']

    #server.vm.provision :shell, inline: 'apt -y update'
    server.vm.provision :salt do |salt|
      salt.masterless = true
      salt.minion_config = "saltminion/minion"
      salt.bootstrap_options = "-X"
      salt.grains_config = "saltminion/grains.yml"

      # Don't run the highstate on the server
      salt.run_highstate = false
    end
  end

  # Defining resources for the VMs
  config.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--memory", 1024]
      v.customize ["modifyvm", :id, "--cpus", 1]
      v.linked_clone = true
  end
end
