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

C="\x1B[0;38;5;156m"
F="\x1B[m"
BARRA="####################################################################################################"

#BPROG() { N=$((N+6)) ; sleep 0.25 ; printf "\e[2;f"$C"${BARRA:0:$N}"$F"\n" ; }
BPROG() { N=$((N+5)) ; sleep 0.25 ; printf "\e[2;f"$C"${BARRA:0:$N}$N%%"$F"\n" ; }

#01
BPROG
echo -e "$Grenn\n Instalando e Configurando APACHE2... $Color_Off"
apt install apache2 -y
a2enmod rewrite env
chmod -R 777 /etc/apache2/
clear

#02
BPROG
echo -e "$Grenn\n Instalando e Configurando PHP7.2... $Color_Off"
apt update
sudo add-apt-repository -y ppa:ondrej/php && sudo apt-get update
sudo apt-get install php7.2-cli libapache2-mod-php7.2 php7.2-mysql php7.2-curl php-memcached php7.2-dev php7.2-sqlite3 php7.2-mbstring php7.2-gd php7.2-json
php -v
clear

#03
BPROG
echo -e "$Grenn\n Instalando e Configurando Composer... $Color_Off"
curl -fSL https://getcomposer.org/composer.phar -o composer.phar
chmod +X composer.phar
sudo apt install composer -y
clear

#04
BPROG
echo -e "$Grenn\n Instalando e Configurando MySQL... $Color_Off"
sudo apt update
clear
BPROG
echo -e "deb http://repo.mysql.com/apt/debian/ stretch mysql-5.7\ndeb-src http://repo.mysql.com/apt/debian/ stretch mysql-5.7" > /etc/apt/sources.list.d/mysql.list
wget -O /tmp/RPM-GPG-KEY-mysql https://repo.mysql.com/RPM-GPG-KEY-mysql --no-check-certificate
BPROG
sudo apt-key add /tmp/RPM-GPG-KEY-mysql
sudo apt update
clear
BPROG
sudo apt install mysql-server -y
clear
BPROG
#systemctl status mysql
echo -e "$Red\n Atenção nessas etapas, pois sem elas o Sistema não Funcionará: $Color_Off"
echo -e "$Red\n 01 - Entre com a senha do Root criada durante a instalação: $Color_Off"
echo -e "$Red\n 02 - Habilite o Plugin: Validate Password $Color_Off"
echo -e "$Red\n 03 - Selecione o "force mode" 0 $Color_Off"
echo -e "$Red\n 04 - Altere a senha do root para: novosga123 $Color_Off"
echo -e "$Red\n 05 - Confirme "y" para as demais opções $Color_Off"
mysql_secure_installation
clear
BPROG
echo -e "$Cyan \n Criando Banco de Dados... $Color_Off"
BPROG
SQL="create database novosgadb; GRANT ALL PRIVILEGES ON novosgadb.* TO novosga@'localhost' IDENTIFIED BY 'novosga123*'; flush privileges;"
mysql -u root -pnovosga123 -e "$SQL" mysql
#mysql -u root -psenha admanager < "/tmp/base_admanager.sql"
clear
BPROG
SQL="uninstall plugin validate_password; ALTER USER 'root'@'localhost' IDENTIFIED BY ''; flush privileges;"
mysql -u root -pnovosga123 -e "$SQL" mysql
quit
clear
BPROG
echo -e "$Cyan \n Banco de Dados Criado Com Sucesso... $Color_Off"
BPROG
echo -e "$Cyan \n Instalando e Configurando NovoSGA... $Color_Off"
php composer.phar create-project "novosga/novosga:2.0" ~/novosga
mv ~/novosga /var/www/html
clear
BPROG
/var/www/html/novosga/bin/console cache:clear --no-debug --no-warmup --env=prod
/var/www/html/novosga/bin/console cache:warmup --env=prod
BPROG
chown www-data:www-data -R /var/www/html/novosga
chmod +w -R /var/www/html/novosga/var/
clear
BPROG
sed -i 's|/var/www/html|/var/www/html/novosga/public|g' /etc/apache2/sites-available/000-default.conf
sed -i 's|AllowOverride None|AllowOverride All|g' /etc/apache2/apache2.conf
echo 'date.timezone = America/Sao_Paulo' > /etc/php/7.2/apache2/conf.d/datetimezone.ini
clear
BPROG
echo 'Options -MultiViews
RewriteEngine On
RewriteCond %{REQUEST_FILENAME} !-f
RewriteRule ^(.*)$ index.php [QSA,L]
SetEnv APP_ENV prod
SetEnv LANGUAGE pt_BR
SetEnv DATABASE_URL mysql://novosga:novosga123@localhost:3306/novosgadb
' > /var/www/html/novosga/public/.htaccess
clear
BPROG
service apache2 restart
BPROG
APP_ENV=prod \
    LANGUAGE=pt_BR \
    DATABASE_URL="mysql://novosga:novosga123@localhost:3306/novosgadb"
    /var/www/html/novosga/bin/console novosga:install
clear
BPROG
echo -e "$Cyan \n NovoSGA Instalado com Sucesso... $Color_Off"
	
################################################################################
