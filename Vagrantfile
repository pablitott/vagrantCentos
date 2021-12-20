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
  # array use: https://github.com/patrickdlee/vagrant-examples/blob/master/example6/Vagrantfile
  # get IP address: VBoxManage guestproperty get "rhSlave1" "/VirtualBox/GuestInfo/Net/0/V4/IP"
  # when a VM enter Guru Meditation state use:
    # vboxmanage startvm <vm-uuid> --type emergencystop

nodes = [
  { :hostname => "rhManager.localnet",   :ip => "192.168.3.101",  :name => "rhManager",  :isManager => true  },
  { :hostname => "rhDatabase.localnet",  :ip => "192.168.3.112",  :name => "rhDatabase", :isManager => false },
  { :hostname => "rhSlave1.localnet",    :ip => "192.168.3.109",  :name => "rhSlave1",   :isManager => false },
  { :hostname => "rhSlave2.localnet",    :ip => "192.168.3.114",  :name => "rhSlave2",   :isManager => false },
]
box_name             = "centos/8"
vm_disk_size         = "10GB"
vm_memory            = 2048
vm_cpus              = 2
vbguest_update       = true
nic_name             = "VirtualBox Host-Only Ethernet Adapter #2"

#TODO use .env file to store variables above,  see https://github.com/gosuri/vagrant-env
Vagrant.configure("2") do |config|
  # following provision is running for all VMs defined
  # I'm using shell provisioning as an example]
  config.vm.provision "shell", privileged: true, inline: <<-SHELL
      echo "Installing common packages for manager and slaves"
      yum update
      echo "Install developer tools"
      yum group install -y "developer tools"
      echo "Install kernel-headers"
      yum install -y kernel-headers
      echo "Install elfutils-libelf-devel"
      yum install -y elfutils-libelf-devel
    SHELL
    # end config.vm.provision
    nodes.each do |node|
      config.vm.define node[:name] do |nodeconfig|
        nodeconfig.vm.box              = box_name
        nodeconfig.vm.box_check_update = false
        nodeconfig.vbguest.auto_update = vbguest_update
        nodeconfig.vbguest.installer_options = { allow_kernel_upgrade: vbguest_update }
        nodeconfig.vm.hostname  =  node[:hostname]
        nodeconfig.vm.disk :disk, size: "#{vm_disk_size}", primary: true
        nodeconfig.vm.network   :private_network, name:nic_name, ip: node[:ip]
        # nodeconfig.vm.network   :private_network, ip: node[:ip]
        nodeconfig.vm.provision :shell, inline: "echo VM #{node[:name]} is ready IP: #{node[:ip]}", run: "always"
        #define mount option to restrict the folder attributes
        nodeconfig.trigger.after :up do |trigger|
          trigger.name = "Finished Message"
          trigger.info = "VM #{node[:name]} is ready IP: #{node[:ip]}"
        end
        # nodeconfig.trigger
        nodeconfig.vm.provider :virtualbox do |v|
          v.memory = vm_memory
          v.name   = node[:name]
          v.cpus   = vm_cpus
        end
        # nodeconfig.vm.provider
        if ( node[:isManager] ) then
          # define managerProvision and ansibleProvision
          nodeconfig.vm.synced_folder "./ansible", "/home/vagrant/ansible", mount_options: ["dmode=775,fmode=777"]
          nodeconfig.vm.provision "managerProvision", type: "shell", path: "bootstrapManager.sh"
          nodeconfig.vm.provision "ansibleProvision", type: "shell", path: "bootstrapAnsible.sh"
        else
          nodeconfig.vm.provision "password", type: "shell", privileged: true, inline: <<-SHELL
            sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
            systemctl restart sshd.service
          SHELL
        end
        # end if
      end
      # config.vm.define
    end
    # end  nodes.each
end
# end of Vagrant.configure

  # config.vm.box_check_update = false
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
