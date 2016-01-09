MYSQL_PASSWORD="root"

echo "[vagrant provisioning] Checking if the box was already provisioned..."

if [ -e "/home/vagrant/.provision_check" ]
then
  # Skipping provisioning if the box is already provisioned
  echo "[vagrant provisioning] The box is already provisioned..."
  exit
fi

# Update Ubuntu
echo "[vagrant provisioning] Update the system..."
sudo apt-get update
sudo apt-get -f -y install

# Installing Python
echo "[vagrant provisioning] Installing pip"
sudo apt-get update
sudo apt-get -y install python-pip

# Installing VirtualEnv
echo "[vagrant provisioning] Installing VirtualEnv"
sudo pip install virtualenv

# Update packages
echo "[vagrant provisioning] Updating the system"
sudo apt-get update

# Upgrate Packages
echo "[vagrant provisioning] Upgrade the packages for development..."
sudo add-apt-repository -y ppa:chris-lea/redis-server
sudo add-apt-repository -y ppa:nginx/stable
sudo add-apt-repository -y ppa:webupd8team/java
sudo add-apt-repository -y ppa:git-core/ppa

# Update packages
echo "[vagrant provisioning] Update the packages..."
sudo apt-get update

# nginx
echo "[vagrant provisioning] Installing nginx..."
sudo apt-get -y install nginx

# MySQL
echo "[vagrant provisioning] Installing mysql-server and mysql-client..."
echo mysql-server mysql-server/root_password select $MYSQL_PASSWORD | debconf-set-selections
echo mysql-server mysql-server/root_password_again select $MYSQL_PASSWORD | debconf-set-selections
sudo apt-get -y install mysql-server mysql-client

# Java
echo "[vagrant provisioning] Installing Java..."
echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
sudo apt-get -y install oracle-jdk7-installer

# Redis
echo "[vagrant provisioning] Installing redis..."
sudo apt-get -y install redis-server

# Git
echo "[vagrant provisioning] Installing git..."
sudo apt-get -y install git

echo "[Vagrant provisioning] Installing mysql-python..."
#pip install mysql-python

# VIM
echo "[vagrant provisioning] Installing vim..."
sudo apt-get -y install vim

# Packages
echo "[vagrant provisioning] Installing additional packages..."
sudo apt-get -y install gcc autoconf bison flex libtool make libboost-all-dev libcurl4-openssl-dev curl libevent-dev uuid-dev libhiredis-dev libmemcached-dev gperf build-essential libmysqlclient-dev

# Create project directory
echo "[vagrant provisioning] Creating /projects folder..."
sudo mkdir /projects

# Upgrate the system packages
echo "[vagrant provisioning] Upgrade the system packages..."
sudo apt-get -y update

echo "[vagrant provisioning] Creating .provision_check file..."
touch .provision_check
