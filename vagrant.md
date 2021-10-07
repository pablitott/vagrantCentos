# Vagrant errors
No guest additions found in the VM Box
check using
> vagrant vbguest --status

verify vbguest additions is installed in host machine
> vagrant plugin install
> vagrant vbguest --do install


Force to install vbguest in host [vagrfant vbguest](https://github.com/dotless-de/vagrant-vbguest)
$ vagrant vbguest [vm-name] [--do start|rebuild|install] [--status] [-f|--force] [-b|--auto-reboot] [-R|--no-remote] [--iso VBoxGuestAdditions.iso] [--no-cleanup]

The error with vbguest was fixed using
> config.vbguest.auto_update = true

examples
````
unless Vagrant.has_plugin?("vagrant-vbguest")
  raise 'The Vagrant VBGuest plugin must be install prior to building this VM (vagrant plugin install vagrant-vbguest)'
end
````
demo how to show messages
````
unless Vagrant.has_plugin?("Bindler")
  puts "--- WARNING ---"
  puts "I'm using Bindler, https://github.com/fgrehm/bindler"
  puts "It's for 'Dead easy Vagrant plugins management'"
  puts "If you have not it installed in your system,"
  puts "visit https://github.com/fgrehm/bindler#installation for more information"
end
````
Allow to install vagrant-vbguest if not unstalled
````
  if !Vagrant.has_plugin?("vagrant-vbguest")
      config.vbguest.auto_update = true
  end
````
### TODO: Check following links and make notes
1. [Environment variables](https://github.com/gosuri/vagrant-env)
2. [Vagrant Triggers](https://www.vagrantup.com/docs/triggers)
