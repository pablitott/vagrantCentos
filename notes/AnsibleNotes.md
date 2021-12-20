# Ansible Notes
## References
  [Book Reference](https://github.com/geerlingguy/ansible-for-devops)
## Initial settings:

````bash
ansible --version
ansible 2.9.25
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/vagrant/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3.6/site-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.6.8 (default, Aug 24 2020, 17:57:11) [GCC 8.3.1 20191121 (Red Hat 8.3.1-5)]

````
### Seting up ansible
- create a hosts.ini
- create a ansible.cfg
set environment variable ANSIBLE_INVENTORY=hosts.ini

create the ssh key
> ssh-keygen -t rsa
to copy the ssh id file use:
> ssh-copy-id vagrant@192.168.3.112

authorized_keys permissions
> chmod 700 ~/.ssh
> chmod 600 ~/.ssh/authorized_keys

Sometimes the ssh-copy-id fail because the remote host does not accept SSH connections
or only accept SSH connections and not passwords, in this case you have to edit file /etc/ssh/sshd_config
in the remote hosts and do following changes

To allow ssh connection edit /etc/ssh/sshd_config and uncomment
> PubkeyAuthentication yes
Optional
> PasswordAuthentication yes
restart sshd
> sudo systemctl restart sshd
in the remote machine
>  ssh-copy-id vagrant@192.168.3.112

after you destroy a VM and creaye a new one, you have to renew the known_hosts files with the new signature
to remove a host name from ~/.ssh/known_hosts
> ssh-keygen -R "hostname"
"hostname" can be the ip address used to connect

## Ad-hoc commands
  [ad-hoc commands](./ad-hoc-commands.md)

## Environment variables
Allow to do not check to add the new file into the authorized_hosts

export ANSIBLE_HOST_KEY_CHECKING=false
export ANSIBLE_CONFIG=/home/vagrant/centos/ansible/ansible.cfg
export ANSIBLE_INVENTORY=hosts.ini

Ansible vault
ansible-vault create credentials.yml

# ansible-vault
source [Ansible Vault](https://docs.ansible.com/ansible/2.9/user_guide/vault.html)
## handle ansible Vault
````bash
# Create a new encrypted data file
ansible-vault create foo.yml

````
## YAML Conventions and best practices
### Collections or arrays
````
widget:
  - foo
  - bar
  - fizz
````
The above will be translated into ranslated_yml = {'widget': ['foo', 'bar', 'fizz']}

````
widget:
  foo: 12
  bar: 13
  fizz
````
The above will be translated into ranslated_yml = {'widget': {'foo':12, , 'bar': 13'}}

## Playbooks
### Real world playbook: CentOS
Location for book example pp. 57
  files:
  - playbooks/playbook1.yml
  - app/app.js
  - app/package.json

