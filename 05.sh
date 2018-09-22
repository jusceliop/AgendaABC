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

echo -e "$Grenn\n Instalação 05... $Color_Off"

echo -e "$Cyan \n Criando Banco de Dados... $Color_Off"
SQL="create database novosgadb; GRANT ALL PRIVILEGES ON novosgadb.* TO novosga@'localhost' IDE$
mysql -u root -pnetrix -e "$SQL" mysql

bash 06.sh
