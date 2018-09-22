#!/bin/sh

#######################################
# Bash script to install an AMP stack and PHPMyAdmin plus tweaks. For Debian based systems.
# Written by @AamnahAkram from http://aamnah.com

# In case of any errors (e.g. MySQL) just re-run the script. Nothing will be re-installed except for the packages with errors.
#######################################

#COLORS
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan

echo -e "$Grenn\n Start... $Color_Off"

echo -e "$Cyan \n Atualizando o Sistema.. $Color_Off"
#sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt-get update -y

echo -e "$Cyan \n Instalando Apache2 $Color_Off"
sudo apt-get -y install apache2

echo -e "$Cyan \n Habilitando modo rewrite $Color_Off"
sudo a2enmod rewrite

echo -e "$Cyan \n Concedendo Permissões Apache2 $Color_Off"
sudo chmod -R 777 /etc/apache2/

echo -e "$Cyan \n Concedendo Permissões para: /var/www $Color_Off"
sudo chown -R www-data:www-data /var/www
echo -e "$Green Permissões Concedidas  $Color_Off"

echo -e "$Cyan \n Verificando Versão Apache2 $Color_Off"
apache2 -v

bash 01.sh
