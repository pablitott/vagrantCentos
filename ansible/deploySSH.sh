###########################################################################
#    Name: deploySSH.sh
#    Creates a SSH key pair and copy the ssh publick key  to all host in the inventory
#
#    define pubkey as:
#    before run this script
#        host_key_checking = False must be set in ansible.cfg
###########################################################################
ssh_id_file=~/.ssh/id_rsa.pub
if [ ! -f $ssh_id_file ]; then
    ssh-keygen -f ~/.ssh/id_rsa -t rsa -P "" -C "" -N ""
fi
ansible-playbook playbooks/deploy_authorized_keys.yml --ask-pass --extra-vars="user=\"$USER\""
