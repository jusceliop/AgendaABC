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

echo -e "$Grenn\n Instalação 03... $Color_Off"

echo -e "$Cyan \n Instalando MySQL $Color_Off"
sudo apt-get -y install mysql-server
echo -e "$Cyan \n Configurando MySQL $Color_Off"
mysql_secure_installation  <<EOF
netrix
n
y
y
y
y
EOF

echo -e "$Cyan \n Verificando Versão MYSQL.. $Color_Off"
mysql -V

echo -e "$Green \n Reiniciando Apache2... $Color_Off"
sudo service apache2 restart

bash  04.sh
