# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Box Setting
  config.vm.box = "minimal/centos7"
  config.vm.hostname = "localuser"
  config.vm.box_check_update = false
  config.vm.box_version = "7.0"
  # Box provider
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false

    # Customize the amount of memory on the VM:
    vb.memory = "256"

    # Customize the amount of cpu on the VM:
    vb.cpus = 1
  end

  #  NetWork Setting
  # config.vm.network "forwarded_port", guest: 80, host: 8989

  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # config.vm.network "private_network", ip: "192.168.33.10"

  # config.vm.network "public_network"

  # Folder Setting
  # config.vm.synced_folder ".", "/home", :mount_options => ["dmode=778", "fmode=666"]

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
     yum update
   SHELL
end
