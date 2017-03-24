#!/bin/bash -e
# PWRTelegram installer script

# Created by Daniil Gentili (https://daniil.it)
# Copyright 2016 Daniil Gentili

#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.

#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.

#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

if [ $(id -u) -ne 0 ]; then
	sudo $0 $*
	exit $?
fi


echo "PWRTelegram installer script  Copyright (C) 2016  Daniil Gentili
This program comes with ABSOLUTELY NO WARRANTY; for details see https://github.com/pwrtelegram/pwrtelegram-backend/blob/master/LICENSE
This is free software, and you are welcome to redistribute it under certain conditions: see https://github.com/pwrtelegram/pwrtelegram-backend/blob/master/LICENSE

This program is created to run on ubuntu.
"
pwrexec() { su pwrtelegram -c "$*"; };
configure() {
	echo "Please enter your mysql database username and password."
	read -p "Username: " username
	read -p "Password: " password
	cd $homedir/pwrtelegram
	echo "Installing database..."
	mysql -u$username -p$password -e 'DROP DATABASE IF EXISTS `pwrtelegram`; CREATE DATABASE `pwrtelegram`;DROP DATABASE IF EXISTS `deeppwrtelegram`; CREATE DATABASE `deeppwrtelegram`;'
	mysql -u$username -p$password < db.sql
	cp dummy_db_connect.php db_connect.php
	sed -i 's/sampleuser/'$username'/g;s/samplepass/'$password'/g' db_connect.php

	cd $homedir/pwrtelegram
	read -p "Type the domain name you intend to use for the main pwrtelegram API server (defaults to api.pwrtelegram.xyz): " api
	[ "$api" == "" ] && api="api.pwrtelegram.xyz"
	read -p "Type the domain name you intend to use for the main deep pwrtelegram API server (defaults to deepapi.pwrtelegram.xyz): " deepapi
	[ "$deepapi" == "" ] && deepapi="deepapi.pwrtelegram.xyz"

	read -p "Type the domain name you intend to use for the beta pwrtelegram API server (defaults to beta.pwrtelegram.xyz): " beta
	[ "$beta" == "" ] && beta="beta.pwrtelegram.xyz"
	read -p "Type the domain name you intend to use for the beta deep pwrtelegram API server (defaults to deepbeta.pwrtelegram.xyz): " deepbeta
	[ "$deepbeta" == "" ] && deepbeta="deepbeta.pwrtelegram.xyz"

	read -p "Type the domain name you intend to use for the pwrtelegram storage server (defaults to storage.pwrtelegram.xyz): " storage
	[ "$storage" == "" ] && storage="storage.pwrtelegram.xyz"
	read -p "Type the domain name you intend to use for the deep pwrtelegram storage server (defaults to deepstorage.pwrtelegram.xyz): " deepstorage
	[ "$deepstorage" == "" ] && deepstorage="deepstorage.pwrtelegram.xyz"

	read -p "Type the domain name you intend to use for the beta pwrtelegram storage server (defaults to betastorage.pwrtelegram.xyz): " betastorage
	[ "$betastorage" == "" ] && betastorage="betastorage.pwrtelegram.xyz"
	read -p "Type the domain name you intend to use for the deep beta pwrtelegram storage server (defaults to deepbetastorage.pwrtelegram.xyz): " deepbetastorage
	[ "$deepbetastorage" == "" ] && deepbetastorage="deepbetastorage.pwrtelegram.xyz"

	echo "Configuring pwrtelegram..."
	sed -i 's/api\.pwrtelegram\.xyz/'$api'/g;s/deepapi\.pwrtelegram\.xyz/'$deepapi'/g;s/beta\.pwrtelegram\.xyz/'$beta'/g;s/deepbeta\.pwrtelegram\.xyz/'$deepbeta'/g;s/storage\.pwrtelegram\.xyz/'$storage'/g;s/deepstorage\.pwrtelegram\.xyz/'$deepstorage'/g;s/betastorage\.pwrtelegram\.xyz/'$betastorage'/g;s/deepbetastorage\.pwrtelegram\.xyz/'$deepbetastorage'/g' Caddyfile storage_url.php

	pwrexec "git clone https://github.com/pwrtelegram/pwrtelegram api"
        cd api
	pwrexec "composer update"
        cd $homedir/pwrtelegram
	pwrexec "git clone https://github.com/pwrtelegram/pwrtelegram beta"
        cd beta
	pwrexec "composer update"
        cd $homedir/pwrtelegram

	#pwrexec "php $homedir/pwrtelegram/login.php"


	echo "That's it, pretty much!
You have configured PWRTelegram in the following way:
Main API server (syncs with pwrtelegram github repo automatically every minute to stay updated): $api
Main deep API server (syncs with pwrtelegram github repo automatically every minute to stay updated): $deepapi
Beta API server (local clone of the PWRTelegram repository that you can use to test new features and debug the API without touching the main API): $beta
Beta deep API server (local clone of the PWRTelegram repository that you can use to test new features and debug the API without touching the main API): $deepbeta
Storage server (script that serves files downloaded by the PWRTelegram API): $storage
Deep storage server (script that serves files downloaded by the deep PWRTelegram API): $deepstorage
Beta storage server (script that serves files downloaded by the PWRTelegram API, uses script located in the beta API): $betastorage
Deep beta storage server (script that serves files downloaded by the deep PWRTelegram API, uses script located in the beta API): $deepbetastorage

Now you have to complete the installation by doing the following things:

1.

Edit $homedir/pwrtelegram/Caddyfile to disable or change the source repo of the PWRTelegram main API.

2.

Once you have finished making your changes start the API with
$homedir/pwrtelegram/start_stop.sh start

3.

Star, watch and submit pull requests to the repositories of this project (https://github.com/pwrtelegram), subscribe to the official PWRTelegram channel (https://telegram.me/pwrtelegram), join the official PWRTelegram chat (https://telegram.me/pwrtelegramgroup), follow the official PWRTelegram account on Twitter (https://twitter.com/PWRTelegram).
Follow the creator (Daniil Gentili, https://daniil.it) on github (https://github.com/danog), contact him on Telegram (https://telegram.me/danogentili) or on Twitter (https://twitter.com/DaniilGentili)

And (optional but recommended) support the developer with a donation @ https://paypal.me/danog :)

Here are the paths of the log files:
* Caddy: $homedir/pwrtelegram/caddy.log
* Main API endpoints (server log): $homedir/pwrtelegram/api.log
* Beta API endpoints (server log): $homedir/pwrtelegram/beta.log
* Main storage endpoints (server log): $homedir/pwrtelegram/storage.log
* Beta storage endpoints (server log): $homedir/pwrtelegram/betastorage.log
* API (php log): /tmp/php-error-index.log
* storage (php log): /tmp/php-error-storage.log
* bots (php log): /tmp/botid.log


Dropping you to a shell as user pwrtelegram...
"
	su pwrtelegram
	echo 'Bye!'
}

if [ "$1" == "docker" -a "$2" == "configure" ];then
	service mysql start
#	service hhvm start
	service php7.0-fpm start
	echo "Create a mysql password"
	mysql=$(dpkg -l | sed '/mysql-server-/!d;/mysql-server-core/d;s/.*mysql-server/mysql-server/g;s/\s.*//g')
	dpkg-reconfigure $mysql
	echo "Create a password for the pwrtelegram user"
	passwd pwrtelegram
	homedir=$( getent passwd "pwrtelegram" | cut -d: -f6 )
	configure
	pwrexec $homedir/pwrtelegram/start_stop.sh start
	exit
fi

# Check required executables
for f in apt-get;do
	which "$f" >/dev/null
done

if ! which wget &>/dev/null;then
	echo "Installing wget, nano and lsb-release..."
	apt-get update
	apt-get --force-yes -y install wget nano lsb-release
fi
# Install required packages

#if [ ! -f /etc/apt/sources.list.d/hhvm.list ]; then
#	echo "Adding hhvm repo..."
#	DISTRIB_CODENAME=$(lsb_release -sc)
#	source /etc/os-release
#	wget -O - http://dl.hhvm.com/conf/hhvm.gpg.key | apt-key add -
#	echo deb http://dl.hhvm.com/$ID "$DISTRIB_CODENAME" main > /etc/apt/sources.list.d/hhvm.list
#fi

echo "Updating package list..."
apt-get update
echo "Updating packages..."
apt-get dist-upgrade --force-yes -y
echo "Installing required packages..."
#apt-get -y --force-yes install hhvm
apt-get -y --force-yes install php-common php7.0 php7.0-bz2 php7.0-cli php7.0-common php7.0-curl php7.0-fpm php7.0-gmp php7.0-json php7.0-mbstring php7.0-mysql php7.0-opcache php7.0-readline php7.0-xml php7.0-mbstring php7.0-gmp
service php7.0-fpm stop
if [ "$1" == "docker" ];then
	debconf-set-selections <<< 'mysql-server mysql-server/root_password password pwrtelegram'
	debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password pwrtelegram'
	apt-get --force-yes -y install curl libreadline-dev libconfig-dev libssl-dev lua5.2 liblua5.2-dev libevent-dev libjansson-dev libpython-dev make build-essential mediainfo wget mysql-server mysql-client automake autoconf libtool git software-properties-common python-software-properties tmux libcap2-bin
else
	apt-get --force-yes -y install curl libreadline-dev libconfig-dev libssl-dev lua5.2 liblua5.2-dev libevent-dev libjansson-dev libpython-dev make build-essential mediainfo wget mysql-server mysql-client automake autoconf libtool git software-properties-common python-software-properties tmux libcap2-bin
fi
update-rc.d php7.0-fpm defaults

if ! which ffprobe &>/dev/null;then
	echo "Installing ffmpeg..."
	[ $(lsb_release -rs | sed 's/\..*//g') == 14 ] && apt-add-repository ppa:mc3man/trusty-media
	apt-get update
	apt-get install ffmpeg --force-yes -y
	which ffprobe >/dev/null

fi

if ! which composer &>/dev/null;then
	echo "Installing composer..."
	curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer
	which composer >/dev/null
fi

if ! which caddy &>/dev/null;then
	echo "Installing caddy..."
	wget -O - https://getcaddy.com | bash -s cors,git,realip,upload
	setcap cap_net_bind_service=+ep /usr/local/bin/caddy
	which caddy >/dev/null
fi

echo "Cleaning up..."
apt-get clean

# Check whether username exists
if ! grep -qE '^pwrtelegram:' /etc/passwd; then
	echo "Creating pwrtelegram user..."
	adduser pwrtelegram << EOF
pwrtelegram
pwrtelegram
PWRTelegram



y

EOF
fi
homedir=$( getent passwd "pwrtelegram" | cut -d: -f6 )

if [ -d $homedir/pwrtelegram ]; then
	[ "$1" == "docker" ] && answer=y || read -p "The pwrtelegram directory already exists. Do you whish to delete it and restart the installation (y/n)? " answer
	[[ $answer =~ ^([yY][eE][sS]|[yY])$ ]] && rm -rf $homedir/pwrtelegram || exit 1
fi

echo "Installing pwrtelegram in $homedir/pwrtelegram..."
cd $homedir
pwrexec git clone --recursive https://github.com/pwrtelegram/pwrtelegram-backend $homedir/pwrtelegram

echo "Configuring stuff..."
cd $homedir/pwrtelegram/
service php7.0-fpm stop
cp -a etc/* /etc/
#sed 's/www-data/pwrtelegram/g' -i /etc/init.d/hhvm
#chown pwrtelegram:pwrtelegram -R /var/run/hhvm/
update-rc.d php7.0-fpm defaults

[ $(lsb_release -rs | sed 's/\..*//g') == 16 ] && systemctl daemon-reload

service php7.0-fpm restart
service mysql start

cd $homedir/pwrtelegram/

if [ "$1" != "docker" ];then
	configure
fi

exit 0
