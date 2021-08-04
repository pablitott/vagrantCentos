#following 4 lines are for slave and manager
#sudo yum update -y
# sudo yum group install -y "developer tools"
# sudo yum install -y kernel-headers
# sudo yum install -y elfutils-libelf-devel

# following lines are only for manager vm
sudo yum install -y epel-release
sudo yum install -y python3
sudo alternatives --set python /usr/bin/python3
sudo yum install -y ansible ansible-doc
sudo yum install -y python3-argcomplete
sudo activate-global-python-argcomplete
ansible --version