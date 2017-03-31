#!/bin/bash

echo "Hi $USER"

# add repos
sudo add-apt-repository -y ppa:webupd8team/sublime-text-2
sudo add-apt-repository -y ppa:webupd8team/java
sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"

# basic update
sudo apt-get -y --force-yes update
sudo apt-get -y --force-yes upgrade

# install apps
sudo apt -y install \
    sublime-text git \
    terminator \
    oracle-java7-installer \
    oracle-java7-set-default curl \
    ubuntu-wallpapers* nodejs-legacy ruby-dev \
    apache2 mysql-server mysql-client \
    php7.0-mysql php7.0-curl php7.0-json php7.0-cgi \
    php7.0 libapache2-mod-php7.0 php7.0* \
    phpmyadmin php-mbstring php7.0-mbstring php-gettext \
    mysql-workbench  python3-pip 

# gems installs
sudo gem install sass
sudo gem install compass

# phpmyadmin fix
echo -e "\n Include /etc/phpmyadmin/apache.conf" | sudo tee -a /etc/apache2/apache2.conf

# restart apache2
sudo /etc/init.d/apache2 restart

# Unistall buggy package PHP
sudo apt-get remove php7.0-snmp

# install Composer
sudo curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# install virtualhost script
cd /usr/local/bin
sudo wget -O virtualhost https://raw.githubusercontent.com/RoverWire/virtualhost/master/virtualhost.sh
sudo chmod +x virtualhost
cd ~/

# make virtual host 
read -p "Please enter your Virtualhost name (example.dev)  : " name
echo ""
sudo virtualhost create $name

# folders
sudo rm -rf ~/Public
sudo rm -rf ~/Templates
sudo rm -rf /var/www/html
sudo rm ~/examples.desktop


# prompt for a reboot
clear
echo ""
echo "#==============================================================#"
echo "#                      TIME FOR A REBOOT!                      #"
echo "#==============================================================#"
echo ""
