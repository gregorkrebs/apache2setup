echo "Easy and Secure Apache2 Webserver Setup"
echo "INFO: installing requirements"
sudo apt update
sudo apt ugrade
sudo apt install ca-certificates apt-transport-https software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt install apache2 curl php php8.3 libapache2-mod-php8.2 php-apcu php-common php-curl php-gd php-gmp php-imagick php-intl php-json php-mbstring php-memcache php-mysql php-zip php8.2-apcu php8.2-bcmath php8.2-cli php8.2-common php8.2-curl php8.2-gd php8.2-gmp php8.2-imagick php8.2-intl php8.2-mbstring php8.2-memcache php8.2-mysql php8.2-opcache php8.2-phpdbg php8.2-readline php8.2-xml php8.2-zip php8.2 mariadb-server mariadb-client
echo "SUCCESSINFO: installing requirements completed"
echo "INFO: enable required and recommended mods"
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
a2enmod php8.2
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
echo "INFO: copy configuration files"
cp conf/hosts.conf /etc/apache2/sites-available/hosts.conf
cp conf/VHosts.conf /etc/apache2/conf-availble/VHosts.conf
cp conf/SSLVHosts.conf /etc/apache2/conf-available/SSLVHosts.conf
cp conf/Proxys.conf /etc/apache2/conf-available/Proxys.conf
echo "INFO: enable config and vhosts-file"
a2ensite hosts
a2enconf VHosts.conf
a2enconf SSLVHosts.conf
a2enconf Proxys.conf
systemctl restart apache2
echo "INFO: Installation successfully completed"
