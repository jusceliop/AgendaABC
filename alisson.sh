#!/bin/sh

sudo apt-get update -y && sudo apt-get upgrade -y
apt install -y software-properties-common python-software-properties
apt-add-repository ppa:ondrej/php
apt update
sudo apt -y install php7.2 php7.2-mysql php7.2-curl php7.2-zip php7.2-intl php7.2-xml php7.2-mb$

sudo chmod -R 777 /etc/php/

php -v
