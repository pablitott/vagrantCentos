## Ad-hoc commands
An a-doc command is a single line with arguments
````bash
# check hostname
ansible multi -a "hostname"
# ping remote
ansible all -m ping
# check the disk space
ansible multi -a "df -H"
#install chrony
ansible multi -b -m yum -a "name=chrony state=present"
# install python3
ansible multi -b -m yum -a "name=python3 state=present"
# verify service is enabled
ansible multi -b -m service -a "name=chronyd state=started enabled=yes"
# Make sure servers are synced closely
ansible multi -b -m "chronyc tracking"
````
Slave1 or app server
````bash
#install pip
ansible app -b -m yum -a "name=python3-pip state=present"
# install dyango using pip
ansible app -b -m pip -a "name=django<4 state=present"
# Check django is installed and working correctly
ansible app -b -m pip -a "name=django --version"
````
Database
````bash
ansible db -b -m yum -a "name=mariadb-server state=present"
ansible db -b -m service -a "name=mariadb state=started enabled=true"
# configure the system firewall
ansible db -b -m yum -a "name=firewalld state=present"
ansible db -b -m service -a "name=firewalld state=started enabled=true"
ansible db -b -m firewalld -a "zone=database state=present permanent=yes"
ansible db -b -m firewalld -a "source=192.168.3.9 state=enabled permanent=yes"
ansible db -b -m firewalld -a "port=3306/tcp state=enabled permanent=yes"
ansible db -b -m yum -a "name=paython3-PyMySQL state=present"
ansible db -b -m mysql_user -a "name=django host=%password=12345 priv=*.*:ALL state:present"
````

Now check the status for chrony
````bash
ansible app -b -a "systemctl status chronyd"
ansible app -b -a "service chronyd restart" --limit "192.168.3.109"
````

### Users
Create users with Ansible
````bash
ansible app -b -m group -a "name=admin state=present"
ansible app -b -m user -a "name=pablitott state=present group=admin createhome=true"
# remove the user
ansible app -b -m user -a "name=pablitott state=absent remove=true"
````
### Install packages
````bash
ansible app -b -m package -a "name=git state=present"
````
### Copy files
````bash
# get information of a file or folder
ansible multi -m stat -a "path=/etc/environment"
# copy a folder
ansible -m copy -a "src=/etc/hosts dest=/tmp/hosts"
# the src can be a file or directory if you include a trailing slash only the content
# will be copied ingto the dest. if you include the trailing slash the content and the directory will be copied
ansible -m fetch -a "src=/etc/hosts dest=~/"
# the dest folder will be 192.168.112\etc/hosts to identify the source
# if you want to copy to specific location use flat-true but the files/fodlers must be unique.
#ansible cron
ansible multi -b -m cron -a "name='daily-cron-all-servers' hour=4 job=/path/to/daily-script.sh
````
### checkout git repositories
````bash
ansible app -b -m git -a "repo=https://github.com/pablitott/nextcloud.git \
dest=/home/vagrant/nextcloud update=true"
````
### execute a batch
````bash
ansible app -b -a "/opt/myapp/update.sh"
````

