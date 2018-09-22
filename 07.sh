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

echo -e "$Grenn\n Instalação 07... $Color_Off"

echo -e "$Cyan \n Realizando Ajustes Novo SGA 2.0 Parte,09... $Color_Off"
echo 'Options -MultiViews
RewriteEngine On
RewriteCond %{REQUEST_FILENAME} !-f
RewriteRule ^(.*)$ index.php [QSA,L]
SetEnv APP_ENV prod
SetEnv LANGUAGE pt_BR
SetEnv DATABASE_URL mysql://novosga:123456@localhost:3306/novosgadb
' > /var/www/html/novosga/public/.htaccess
echo -e "$Cyan \n Realizando Ajustes Novo SGA 2.0 Parte,10... $Color_Off"
service apache2 restart

bash 08.sh
