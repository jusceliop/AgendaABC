#!/bin/sh

#######################################
#Instalando Novo SGA 2.0 Ubuntu/Debian
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


echo -e "$Grenn\n Instalação 01... $Color_Off"

echo -e "$Cyan \n Atualizando o Sistema.. $Color_Off"
sudo apt-get update -y && sudo apt-get upgrade -y

echo -e "$Cyan \n Instalando PHP e Dependências $Color_Off"
apt install -y software-properties-common python-software-properties
apt-add-repository ppa:ondrej/php
apt update
sudo apt -y install php7.2 php7.2-mysql php7.2-curl php7.2-zip php7.2-intl php7.2-xml php7.2-mb$

echo -e "$Cyan \n Concedendo Permissões PHP $Color_Off"
sudo chmod -R 777 /etc/php/
echo -e "$Green Permissões Concedidas  $Color_Off"

echo -e "$Cyan \n Verificando Versão PHP.. $Color_Off"
php -v

bash 02.sh
