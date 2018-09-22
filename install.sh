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

echo -e "$Cyan \n Atualizando o Sistema.. $Color_Off"
sudo apt-get update -y && sudo apt-get upgrade -y

echo -e "$Cyan \n Instalando Apache2 $Color_Off"
sudo apt-get -y install apache2

echo -e "$Cyan \n Verificando Versão Apache2 $Color_Off"
apache2 -v

echo -e "$Cyan \n Atualizando o Sistema.. $Color_Off"
sudo apt-get update -y && sudo apt-get upgrade -y

echo -e "$Cyan \n Instalando PHP e Dependências $Color_Off"
apt install -y software-properties-common python-software-properties -P
apt-add-repository ppa:ondrej/php
apt update
sudo apt -y install php7.2 php7.2-mysql php7.2-curl php7.2-zip php7.2-intl php7.2-xml php7.2-mb$

echo -e "$Cyan \n Verificando Versão PHP.. $Color_Off"
php -v

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

#echo -e "$Cyan \n Instalando phpMyAdmin $Color_Off"
#sudo apt-get install phpmyadmin -y

echo -e "$Cyan \n Verificando Instalações $Color_Off"
apache2 -v
php -v
mysql -V

echo -e "$Cyan \n Concedendo Permissões para: /var/www $Color_Off"
sudo chown -R www-data:www-data /var/www
echo -e "$Green Permissões Concedidas  $Color_Off"

echo -e "$Cyan \n Habilitando modo rewrite $Color_Off"
sudo a2enmod rewrite

echo -e "$Cyan \n Concedendo Permissões Apache2 $Color_Off"
sudo chmod -R 777 /etc/apache2/
echo -e "$Green Permissões Concedidas  $Color_Off"
echo -e "$Cyan \n Concedendo Permissões PHP $Color_Off"
sudo chmod -R 777 /etc/php/
echo -e "$Green Permissões Concedidas  $Color_Off"

echo -e "$Cyan \n Concedendo Permissões... $Color_Off"
sudo chown -R www-data:www-data /var/www
sudo chmod -R 777 /etc/apache2/
sudo chmod -R 777 /etc/php/
sudo a2enmod rewrite

echo -e "$Green \n Reiniciando Apache2... $Color_Off"
sudo service apache2 restart

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

echo -e "$Cyan \n Criando Banco de Dados... $Color_Off"
SQL="create database novosgadb; GRANT ALL PRIVILEGES ON novosgadb.* TO novosga@'localhost' IDE$
mysql -u root -pnetrix -e "$SQL" mysql

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

echo -e "$Cyan \n Realizando Ajustes Novo SGA 2.0 Parte,11... $Color_Off"
APP_ENV=prod \
    LANGUAGE=pt_BR \
    DATABASE_URL="mysql://novosga:123456@localhost:3306/novosgadb"
    /var/www/html/novosga/bin/console novosga:install
