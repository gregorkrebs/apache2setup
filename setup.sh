echi "Automatic Secure Apache2 Webserver Setup"
echo "INFO: installing requirements"
sudo apt update
sudo apt ugrade
sudo apt install python3 php php-apcu php-common curl php-curl php-gd php-gmp php-imagick php-intl php-json php-mbstring php-memcache php-mysql php-zip php8.1-apcu php8.1-bcmath php8.1-cli php8.1-common php8.1-curl php8.1-gd php8.1-gmp php8.1-imagick php8.1-intl php8.1-mbstring php8.1-memcache php8.1-mysql php8.1-opcache php8.1-phpdbg php8.1-readline php8.1-xml php8.1-zip php8.1 apache2 mariadb-server mariadb-client
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
a2enmod php8.1
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
