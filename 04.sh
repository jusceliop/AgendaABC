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

echo -e "$Grenn\n Instalação 04... $Color_Off"

echo -e "$Cyan \n Instalando Curls $Color_Off"
sudo apt-get install curl -y

echo -e "$Cyan \n Instalando Composer... $Color_Off"
curl -fSL https://getcomposer.org/composer.phar -o composer.phar

echo -e "$Cyan \n Permissões Composer... $Color_Off"
chmod +X composer.phar

echo -e "$Cyan \n Movendo Composer... $Color_Off"
mv composer.phar /usr/local/bin/composer

echo -e "$Cyan \n Permissões Composer... $Color_Off"
chmod 775 /usr/local/bin/composer
curl -fSL https://getcomposer.org/composer.phar -o composer.phar

bash 05.sh
