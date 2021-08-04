## Network configuration
In order to configure network to be used in these virtual machines, we have to use 2 network interfaces
* NAT
* Host-Only Adapter

Host Only adapter is the default private network in vagrant, to use specific settings, you have to create a network interface in Virtuak Box as:
````
              Name: "VirtualBox Host-Only Ethernet Adapter"
      IPv4 Address: "192.168.3.1"
 IPv4 Network Mask: "255.255.0.0"
````
![](vagrant_network1.JPG)
And DHCP Server settings as:
````
Server Address: 192.168.3.1
Server Mask: 255.255.255.0
Lower Address Bound: 192.168.3.100
Upper Address Bound: 192.168.3.254
````
![](vagrant_network_dhcp.JPG)


## Ansible Hosts
> vi /etc/ansible/hosts
add the address from slaves then
> ansible all --list-hosts

### Create ssh key files
> ssh-keygen
In rhSlave1 modify /etc/ssh/sshd_config  and uncomment the line
   - PasswordAuthentication yes
and comment the line
   - PasswordAuthentication no
re-start ssh config as:
> sudo systemctl reload sshd

go to Manager Machine and copy the ssh key to Slave machine
> ssh-copy-id vagrant@rhSlave1
password for vagrant user is vagrant by default

go back to rhSlave1 and undo changes as
In rhSlave1 modify /etc/ssh/sshd_config  and uncomment the line
   - PasswordAuthentication yes
and comment the line
   - PasswordAuthentication no
re-start ssh config as:
> sudo systemctl reload sshd

### to change the sshd_config by script you can use:
````
  to remove the # in front of *PasswordAuthentication yes*
   sudo cp sudo sed -re 's/^(\#)(PasswordAuthentication)([[:space:]]+)(.*)/\2\3\4/' /etc/ssh/sshd_config > ./sshd_config.new
````
*save the new document in the PWD because need root access to be saved in /etc/ssh*

  to add # in front of *PasswordAuthentication yes* is <p style="color:red">NOT POSSIBLE</p>

test the ansible connections as:
> ansible -m ping all
Output:
192.168.3.109 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/libexec/platform-python"
    },
    "changed": false,
    "ping": "pong"
}
for Ansible documentation see [Ansible docs](https://docs.ansible.com/ansible/latest/)

Ansible man pages are:
   - ansible-config
   - ansible-console
   - ansible-galaxy
   - ansible-inventory
   - ansible-playbook
   - ansible-pull
   - ansible-vault
   - ansible-doc

Ansible plugins Types
   - become
   - cache
   - callback
   - cliconf
   - connection
   - httpapi
   - inventory
   - lookup
   - netconf
   - shell
   - strategy
   - vars

## Ansible inventory
   - List or hosts to work against
   - Host or groups of hosts are targeted for action
   - Default inventory file - /etc/ansible/hosts
   - Ansible-playbook -i /home/user1/hosts
   -
