#!/bin/bash

# Shell script by Balu sreekanth
# balusreekanth@gmail.com



get_linux_distribution ()
{ 

if lsb_release -sr | grep '20'; then
   DIST="UBUNTU 20"
else
  echo "Sorry This script may not work on this system"
  exit 1
fi

}





post_asterisk_install()
{

sudo groupadd asterisk
sudo useradd -r -d /var/lib/asterisk -g asterisk asterisk
sudo usermod -aG audio,dialout asterisk
sudo chown -R asterisk.asterisk /etc/asterisk
sudo chown -R asterisk.asterisk /var/{lib,log,spool}/asterisk
sudo chown -R asterisk.asterisk /usr/lib/asterisk

sed -i '/AST_USER/s/^#//g' /etc/default/asterisk
sed -i '/AST_GROUP/s/^#//g' /etc/default/asterisk
sed -i '/runuser/s/^;//g' /etc/asterisk/asterisk.conf
sed -i '/rungroup/s/^;//g' /etc/asterisk/asterisk.conf

sudo systemctl restart asterisk
sudo systemctl enable asterisk

	

}


configure_firewall()

{
sudo ufw enable
sudo ufw allow 5060
sudo ufw allow 5061

}


installation_done()
{

    sudo apt  -y install net-tools

IP=$(dig +short myip.opendns.com @resolver1.opendns.com)

echo "******************************************************************************************"
        echo "******************************************************************************************"
        echo "******************************************************************************************"
        echo "**********                                                                      **********"
        echo "**********           FreePBX installed successfully                       **********"
        echo "                     Browse URL: http://${IP}/admin"
        
        echo "**********  Need Help ?Give me a shout balusreekanth@gmail.com            **********"
        echo "******************************************************************************************"
        echo "******************************************************************************************"
        echo "******************************************************************************************"

	
}

install_freepbx(){
	
	sudo apt  -y install mariadb-server
	sudo apt-get  -y install apache2
	sudo cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf_orig
sudo sed -i 's/^\(User\|Group\).*/\1 asterisk/' /etc/apache2/apache2.conf
sudo sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

sudo add-apt-repository ppa:ondrej/php  
sudo apt-get update  
     
sudo apt-get -y install php7.3  
sudo apt-get -y install php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-mysql php7.3-mbstring  php7.3-zip php7.3-fpm php7.3-intl php7.3-simplexml  
     
sudo a2dismod php7.4  
sudo a2enmod php7.3  
sudo service apache2 restart  
     
sudo update-alternatives --set php /usr/bin/php7.3  
sudo update-alternatives --set phar /usr/bin/phar7.3  
sudo update-alternatives --set phar.phar /usr/bin/phar.phar7.3  
sudo update-alternatives --set phpize /usr/bin/phpize7.3  
sudo update-alternatives --set php-config /usr/bin/php-config7.3  

sudo apt-get -y install wget gettext libapache2-mod-php php-{pear,cgi,common,curl,mbstring,gd,mysql,bcmath,zip,xml,imap,json,snmp,fpm}

sudo sed -i 's/\(^upload_max_filesize = \).*/\120M/' /etc/php/7.3/apache2/php.ini
sudo sed -i 's/\(^upload_max_filesize = \).*/\120M/' /etc/php/7.3/cli/php.ini

cd /usr/src
sudo wget http://mirror.freepbx.org/modules/packages/freepbx/freepbx-15.0-latest.tgz
sudo tar xfz freepbx-15.0-latest.tgz
sudo rm -f freepbx-15.0-latest.tgz
cd freepbx
sudo ./start_asterisk start
sudo apt -y install nodejs npm
sudo ./install -n


sudo a2enmod rewrite
sudo systemctl restart apache2


}


install_asterisk ()
{
	
sudo apt -y update &&  sudo apt-get -y  install git curl wget libnewt-dev libssl-dev libncurses5-dev subversion libsqlite3-dev build-essential libjansson-dev libxml2-dev  uuid-dev

cd /usr/src/

curl -O http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-16-current.tar.gz

tar xvf asterisk-16-current.tar.gz
cd asterisk-16*/

sudo contrib/scripts/get_mp3_source.sh

sudo contrib/scripts/install_prereq install

./configure


make menuselect
make
make install
make samples
make config
ldconfig
}









start_installation ()
{
 get_linux_distribution
 install_asterisk
 post_asterisk_install
 install_freepbx
 installation_done

}


start_installation
