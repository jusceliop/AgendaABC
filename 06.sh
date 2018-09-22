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

echo -e "$Grenn\n Instalação 06... $Color_Off"

echo -e "$Cyan \n Criando Projeto Novo SGA 2.0... $Color_Off"
php composer.phar create-project "novosga/novosga:^2" ~/novosga
echo -e "$Cyan \n Realizando Ajustes Novo SGA 2.0 Parte,01... $Color_Off"
mv ~/novosga /var/www/html
echo -e "$Cyan \n Realizando Ajustes Novo SGA 2.0 Parte,02... $Color_Off"
/var/www/html/novosga/bin/console cache:clear --no-debug --no-warmup --env=prod
echo -e "$Cyan \n Realizando Ajustes Novo SGA 2.0 Parte,03... $Color_Off"
/var/www/html/novosga/bin/console cache:warmup --env=prod
echo -e "$Cyan \n Realizando Ajustes Novo SGA 2.0 Parte,04... $Color_Off"
chown www-data:www-data -R /var/www/html/novosga
echo -e "$Cyan \n Realizando Ajustes Novo SGA 2.0 Parte,05... $Color_Off"
chmod +w -R /var/www/html/novosga/var/
echo -e "$Cyan \n Realizando Ajustes Novo SGA 2.0 Parte,06... $Color_Off"
sed -i 's|/var/www/html|/var/www/html/novosga/public|g' /etc/apache2/sites-available/000-defau$
echo -e "$Cyan \n Realizando Ajustes Novo SGA 2.0 Parte,07... $Color_Off"
sed -i 's|AllowOverride None|AllowOverride All|g' /etc/apache2/apache2.conf
echo -e "$Cyan \n Realizando Ajustes Novo SGA 2.0 Parte,08... $Color_Off"
echo 'date.timezone = America/Sao_Paulo' > /etc/php/7.1/apache2/conf.d/datetimezone.ini

bash 07.sh
