#!/usr/bin/env bash
set -euo pipefail

echo "Easy and Secure Apache2 Webserver Setup"
echo "[INFO] installing requirements"
export DEBIAN_FRONTEND=noninteractive
APT_INSTALL_FLAGS=(-y)
if [ "${APT_NO_INSTALL_RECOMMENDS:-0}" = "1" ]; then
    APT_INSTALL_FLAGS+=(--no-install-recommends)
fi
sudo apt update
sudo apt-get -y upgrade
OS_ID=$(grep '^ID=' /etc/os-release | cut -d'=' -f2)
OS_ID=${OS_ID//\"/}
echo "[INFO] Installing requirements"
sudo apt install ca-certificates software-properties-common certbot python3-certbot-apache "${APT_INSTALL_FLAGS[@]}"
case $OS_ID in
    ubuntu)
        echo "Ubuntu"
        sudo add-apt-repository ppa:ondrej/php -y
        ;;
    debian)
        echo "Debian"
        ;;
    *)
        echo "Unknown distribution: $OS_ID"
        ;;
esac
sudo apt update
sudo apt install apache2 curl php php-apcu php-common php-curl php-gd php-gmp php-imagick php-intl php-json php-mbstring php-memcache php-mysql php-zip mariadb-server mariadb-client "${APT_INSTALL_FLAGS[@]}"

php_versions=(7.4 8.0 8.1 8.2 8.3)
for version in "${php_versions[@]}"; do
    if apt-cache show "php$version" >/dev/null 2>&1; then
        sudo apt install "php$version" "php$version-fpm" "libapache2-mod-php$version" \
            "php$version-apcu" "php$version-bcmath" "php$version-cli" "php$version-common" \
            "php$version-curl" "php$version-gd" "php$version-gmp" "php$version-imagick" \
            "php$version-intl" "php$version-mbstring" "php$version-memcache" \
            "php$version-mysql" "php$version-opcache" "php$version-phpdbg" \
            "php$version-readline" "php$version-xml" "php$version-zip" "${APT_INSTALL_FLAGS[@]}"
    else
        echo "[WARN] PHP $version is not available in this repository, skipping."
    fi
done

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
a2enmod reqtimeout
a2enmod rewrite
a2enmod setenvif
a2enmod socache_shmcb
a2enmod ssl
a2enmod status
a2enmod vhost_alias
a2enmod xml2enc
a2enmod proxy_fcgi proxy_wstunnel setenvif
for version in "${php_versions[@]}"; do
    if [ -e "/etc/apache2/conf-available/php$version-fpm.conf" ]; then
        a2enconf "php$version-fpm"
    fi
done
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
