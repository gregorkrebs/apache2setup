echo "Easy and Secure Apache2 Webserver Setup"
echo "[INFO] installing requirements"
sudo apt update
sudo apt upgrade -y
sudo apt install ca-certificates apt-transport-https software-properties-common certbot python3-certbot-apache -y
sudo apt install apache2 curl php php-apcu php-common php-curl php-gd php-gmp php-imagick php-intl php-json php-mbstring php-memcache php-mysql php-zip mariadb-server mariadb-client -y
sudo apt install php7.4 php7.4-fpm libapache2-mod-php7.4 php7.4-apcu php7.4-bcmath php7.4-cli php7.4-common php7.4-curl php7.4-gd php7.4-gmp php7.4-imagick php7.4-intl php7.4-mbstring php7.4-memcache php7.4-mysql php7.4-opcache php7.4-phpdbg php7.4-readline php7.4-xml php7.4-zip -y
sudo apt install php8.0 php8.0-fpm libapache2-mod-php8.0 php8.0-apcu php8.0-bcmath php8.0-cli php8.0-common php8.0-curl php8.0-gd php8.0-gmp php8.0-imagick php8.0-intl php8.0-mbstring php8.0-memcache php8.0-mysql php8.0-opcache php8.0-phpdbg php8.0-readline php8.0-xml php8.0-zip -y
sudo apt install php8.1 php8.1-fpm libapache2-mod-php8.1 php8.1-apcu php8.1-bcmath php8.1-cli php8.1-common php8.1-curl php8.1-gd php8.1-gmp php8.1-imagick php8.1-intl php8.1-mbstring php8.1-memcache php8.1-mysql php8.1-opcache php8.1-phpdbg php8.1-readline php8.1-xml php8.1-zip -y
sudo apt install php8.2 php8.2-fpm libapache2-mod-php8.2 php8.2-apcu php8.2-bcmath php8.2-cli php8.2-common php8.2-curl php8.2-gd php8.2-gmp php8.2-imagick php8.2-intl php8.2-mbstring php8.2-memcache php8.2-mysql php8.2-opcache php8.2-phpdbg php8.2-readline php8.2-xml php8.2-zip -y
sudo apt install php8.3 php8.3-fpm libapache2-mod-php8.3 php8.3-apcu php8.3-bcmath php8.3-cli php8.3-common php8.3-curl php8.3-gd php8.3-gmp php8.3-imagick php8.3-intl php8.3-mbstring php8.3-memcache php8.3-mysql php8.3-opcache php8.3-phpdbg php8.3-readline php8.3-xml php8.3-zip -y
echo "[INFO] enable required and recommended mods"
a2dissite 000-default
a2dissite default-ssl
a2enmod access_compat
a2enmod alias
a2enmod auth_basic
a2enmod authn_core
a2enmod authn_file
a2enmod authz_core
a2enmod authz_host
a2enmod authz_user
a2enmod autoindex
a2enmod brotli
a2enmod deflate
a2enmod dir
a2enmod filter
a2enmod headers
a2enmod http2
a2enmod macro
a2enmod mime
a2enmod mpm_prefork
a2enmod negotiation
a2enmod proxy
a2enmod proxy_fdpass
a2enmod proxy_html
a2enmod proxy_http2
a2enmod proxy_http
a2enmod proxy
a2enmod reqtimeout
a2enmod rewrite
a2enmod setenvif
a2enmod socache_shmcb
a2enmod ssl
a2enmod status
a2enmod vhost_alias
a2enmod xml2enc
a2enmod proxy_fcgi setenvif
a2enconf php7.4-fpm
a2enconf php8.0-fpm
a2enconf php8.1-fpm
a2enconf php8.2-fpm
a2enconf php8.3-fpm
echo "[INFO] Copy configuration files"
cp sites/hosts.conf /etc/apache2/sites-available/hosts.conf
cp sites/LE-template.conf /etc/apache2/sites-available/LE-template.conf
cp conf/vHosts.conf /etc/apache2/conf-available/vHosts.conf
cp conf/SSLvHosts.conf /etc/apache2/conf-available/SSLvHosts.conf
cp conf/Proxys.conf /etc/apache2/conf-available/Proxys.conf
cp conf/SSLProxys.conf /etc/apache2/conf-available/SSLProxys.conf
echo "[INFO] Enable config and vhosts-file"
a2ensite hosts.conf
a2enconf vHosts.conf
a2enconf SSLvHosts.conf
a2enconf SSLProxys.conf
a2enconf Proxys.conf
echo "[INFO] Restart apache2"
systemctl restart apache2
echo "[INFO] Installation successfully completed"
