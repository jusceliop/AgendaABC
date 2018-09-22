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

# Atualizando o Sistema
echo -e "$Cyan \n Atualizando o Sistema.. $Color_Off"
sudo apt-get update -y && sudo apt-get upgrade -y

## Instalando Apache
echo -e "$Cyan \n Instalando Apache2 $Color_Off"
sudo apt-get install apache2 apache2-doc apache2-mpm-prefork apache2-utils libexpat1 ssl-cert -y

echo -e "$Cyan \n Instalando PHP e Dependências $Color_Off"
apt install software-properties-common python-software-properties -y
apt-add-repository ppa:ondrej/php -y
apt update
sudo apt install php7.2 php7.2-mysql php7.2-curl php7.2-zip php7.2-intl php7.2-xml php7.2-mbstring php-gettext -y

echo -e "$Cyan \n Instalando MySQL $Color_Off"
sudo apt-get install mysql-server mysql-client libmysqlclient15.dev -y
#mysql_secure_installation

#echo -e "$Cyan \n Instalando phpMyAdmin $Color_Off"
#sudo apt-get install phpmyadmin -y

echo -e "$Cyan \n Verificando Instalações $Color_Off"
apache2 -v
php -v
mysql -v

## Ajustando Configurações
# Permissions
echo -e "$Cyan \n Permissões for /var/www $Color_Off"
sudo chown -R www-data:www-data /var/www
echo -e "$Green \n Permissions have been set $Color_Off"

# Habilitando rewrite
echo -e "$Cyan \n Habilitando Módulos $Color_Off"
sudo a2enmod rewrite
sudo chmod -R 777 /etc/apache2/
sudo chmod -R 777 /etc/php/

# Reiniciar Apache2
echo -e "$Cyan \n Reiniciando Apache2 $Color_Off"
sudo service apache2 restart

#Instalando Composer
echo -e "$Cyan \n Instalando Composer... $Color_Off"
curl -fSL https://getcomposer.org/composer.phar -o composer.phar

#Permissão Composer
echo -e "$Cyan \n Permissões Composer... $Color_Off"
chmod +X composer.phar
mv composer.phar /usr/local/bin/composer

#Atualizando Composer
echo -e "$Cyan \n Atualizando Composer... $Color_Off"
curl -fSL https://getcomposer.org/composer.phar -o composer.phar
composer self-update

#Criando Banco de Dados
echo -e "$Cyan \n Criando Banco de Dados... $Color_Off"
CREATE DATABASE novosgadb;
echo -e "$Cyan \n Criando Usuário... $Color_Off"
CREATE USER 'novosga'@'localhost' IDENTIFIED BY '123456';
echo -e "$Cyan \n Concedendo Acessos/Privilégios... $Color_Off"
GRANT ALL PRIVILEGES ON novosgadb.* TO 'novosga'@'localhost' IDENTIFIED BY '123456';
FLUSH PRIVILEGES;
echo -e "$Cyan \n Finalizando... $Color_Off"
exit;

#Criando Projeto Novo SGA 2.0
echo -e "$Cyan \n Criando Projeto Novo SGA 2.0... $Color_Off"
php composer.phar create-project "novosga/novosga:^2" ~/novosga

#Criando Projeto Novo SGA 2.0
echo -e "$Cyan \n Realizando Ajustes Novo SGA 2.0 Parte,01... $Color_Off"
mv ~/novosga /var/www/html

#Criando Projeto Novo SGA 2.0
echo -e "$Cyan \n Realizando Ajustes Novo SGA 2.0 Parte,02... $Color_Off"
/var/www/html/novosga/bin/console cache:clear --no-debug --no-warmup --env=prod

#Criando Projeto Novo SGA 2.0
echo -e "$Cyan \n Realizando Ajustes Novo SGA 2.0 Parte,03... $Color_Off"
/var/www/html/novosga/bin/console cache:warmup --env=prod

#Criando Projeto Novo SGA 2.0
echo -e "$Cyan \n Realizando Ajustes Novo SGA 2.0 Parte,04... $Color_Off"
chown www-data:www-data -R /var/www/html/novosga

#Criando Projeto Novo SGA 2.0
echo -e "$Cyan \n Realizando Ajustes Novo SGA 2.0 Parte,05... $Color_Off"
chmod +w -R /var/www/html/novosga/var/

#Criando Projeto Novo SGA 2.0
echo -e "$Cyan \n Realizando Ajustes Novo SGA 2.0 Parte,06... $Color_Off"
sed -i 's|/var/www/html|/var/www/html/novosga/public|g' /etc/apache2/sites-available/000-default.conf

#Criando Projeto Novo SGA 2.0
echo -e "$Cyan \n Realizando Ajustes Novo SGA 2.0 Parte,07... $Color_Off"
sed -i 's|AllowOverride None|AllowOverride All|g' /etc/apache2/apache2.conf

#Criando Projeto Novo SGA 2.0
echo -e "$Cyan \n Realizando Ajustes Novo SGA 2.0 Parte,08... $Color_Off"
echo 'date.timezone = America/Sao_Paulo' > /etc/php/7.1/apache2/conf.d/datetimezone.ini

#Criando Projeto Novo SGA 2.0
echo -e "$Cyan \n Realizando Ajustes Novo SGA 2.0 Parte,09... $Color_Off"
echo 'Options -MultiViews
RewriteEngine On
RewriteCond %{REQUEST_FILENAME} !-f
RewriteRule ^(.*)$ index.php [QSA,L]
SetEnv APP_ENV prod
SetEnv LANGUAGE pt_BR
SetEnv DATABASE_URL mysql://novosga:123456@localhost:3306/novosgadb
' > /var/www/html/novosga/public/.htaccess

#Criando Projeto Novo SGA 2.0
echo -e "$Cyan \n Realizando Ajustes Novo SGA 2.0 Parte,10... $Color_Off"
service apache2 restart

#Criando Projeto Novo SGA 2.0
echo -e "$Cyan \n Realizando Ajustes Novo SGA 2.0 Parte,11... $Color_Off"
APP_ENV=prod \
    LANGUAGE=pt_BR \
    DATABASE_URL="mysql://novosga:123456@localhost:3306/novosgadb"
    /var/www/html/novosga/bin/console novosga:install
