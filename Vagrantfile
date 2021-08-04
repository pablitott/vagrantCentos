# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
Vagrant.configure("2") do |config|
  config.vm.box       = "centos/8"
  config.vm.disk :disk, size: "10GB", primary: true
  # following provision is running for all VMs defined
  config.vm.provision "shell", inline: <<-SHELL
      echo "Installing common packages for manager and slaves"
      sudo yum update
      echo "Install developer tools"
      sudo yum group install -y "developer tools"
      echo "Install kernel-headers"
      sudo yum install -y kernel-headers
      echo "Install elfutils-libelf-devel"
      sudo yum install -y elfutils-libelf-devel
    SHELL

  config.vm.define "rhManager" do |rhManager|
    rhManager.vm.provision :shell, path: "bootstrapManager.sh"
    rhManager.vm.hostname  = "rhManager.localnet.com"
    rhManager.vm.network :private_network, name: "VirtualBox Host-Only Ethernet Adapter", ip: "192.168.3.108"
    rhManager.vm.provision :shell, inline: "echo VM rhManager is ready IP: 192.168.3.108", run: "always"

    rhManager.vm.provider :virtualbox do |v|
      v.memory = 2048
      v.name   = "rhManager"
      v.cpus   = 2
    end
  end

  config.vm.define "rhSlave1" do |rhSlave1|
    rhSlave1.vm.hostname  = "rhSlave1.localnet.com"
    rhSlave1.vm.network :private_network, name: "VirtualBox Host-Only Ethernet Adapter", ip: "192.168.3.109"
    rhSlave1.vm.provision :shell, inline: "echo VM rhSlave1 is ready IP: 192.168.3.108", run: "always"

    rhSlave1.vm.provider :virtualbox do |v|
      v.memory = 2048
      v.name   = "rhSlave1"
      v.cpus   = 2
    end
  end

end

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
