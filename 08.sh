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

echo -e "$Grenn\n Instalação 08... $Color_Off"

echo -e "$Cyan \n Realizando Ajustes Novo SGA 2.0 Parte,11... $Color_Off"
APP_ENV=prod \
    LANGUAGE=pt_BR \
    DATABASE_URL="mysql://novosga:123456@localhost:3306/novosgadb"
    /var/www/html/novosga/bin/console novosga:install

echo -e "$Cyan \n SGA Instalado com Sucesso!$Color_Off"

