echo "Installing common packages for manager and slaves"
sudo yum update
echo "Install developer tools"
sudo yum group install -y "developer tools"
echo "Install kernel-headers"
sudo yum install -y kernel-headers
echo "Install elfutils-libelf-devel"
sudo yum install -y elfutils-libelf-devel
