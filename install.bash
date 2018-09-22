apt-get update && apt-get -y upgrade
apt install apache2
a2enmod rewrite env
chmod -R 777 /etc/apache2/
apt-get update && apt-get -y upgrade
apt-get install software-properties-common python-software-properties
apt-add-repository ppa:ondrej/php
apt-get update
apt-get -y install php7.2 php7.2-mysql php7.2-curl php7.2-zip php7.2-intl php7.2-xml php7.2-mbstring php-gettext
chmod -R 777 /etc/php/
curl -fSL https://getcomposer.org/composer.phar -o composer.phar
chmod +X composer.phar
mv composer.phar /usr/local/bin/composer
composer self-update
curl -fSL https://getcomposer.org/composer.phar -o composer.phar
chmod +X composer.phar
apt-get update
apt-get -y install mysql-server
mysql_secure_installation
mysql -u root -p netrix
CREATE DATABASE novosgadb;
CREATE USER 'novosga'@'localhost' IDENTIFIED BY 'Netrix&2005*';
GRANT ALL PRIVILEGES ON novosgadb.* TO 'novosga'@'localhost' IDENTIFIED BY 'Netrix&2005*';
FLUSH PRIVILEGES;
exit;
php composer.phar create-project "novosga/novosga:^2" ~/novosga
mv ~/novosga /var/www/html
/var/www/html/novosga/bin/console cache:clear --no-debug --no-warmup --env=prod
/var/www/html/novosga/bin/console cache:warmup --env=prod
chown www-data:www-data -R /var/www/html/novosga
chmod +w -R /var/www/html/novosga/var/
sed -i 's|/var/www/html|/var/www/html/novosga/public|g' /etc/apache2/sites-available/000-default.conf
sed -i 's|AllowOverride None|AllowOverride All|g' /etc/apache2/apache2.conf
echo 'date.timezone = America/Sao_Paulo' > /etc/php/7.2/apache2/conf.d/datetimezone.ini
echo 'Options -MultiViews
RewriteEngine On
RewriteCond %{REQUEST_FILENAME} !-f
RewriteRule ^(.*)$ index.php [QSA,L]
SetEnv APP_ENV prod
SetEnv LANGUAGE pt_BR
SetEnv DATABASE_URL mysql://novosga:Netrix&2005*@localhost:3306/novosgadb
' > /var/www/html/novosga/public/.htaccess
service apache2 restart

mysql -u root -p netrix
uninstall plugin validate_password;
ALTER USER 'root'@'localhost' IDENTIFIED BY '';
quit

APP_ENV=prod \
    LANGUAGE=pt_BR \
    DATABASE_URL="mysql://novosga:Netrix&2005*@localhost:3306/novosgadb"
    /var/www/html/novosga/bin/console novosga:install
	
