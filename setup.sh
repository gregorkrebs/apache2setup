#!/usr/bin/env bash
set -euo pipefail

if [[ $EUID -ne 0 ]]; then
    echo "[INFO] Elevating privileges for setup"
    sudo -v
    exec sudo -E bash "$0" "$@"
fi

echo "Easy and Secure Apache2 Webserver Setup"
echo "[INFO] installing requirements"
sudo apt update
sudo apt upgrade -y
OS_ID=$(grep '^ID=' /etc/os-release | cut -d'=' -f2)
OS_ID=${OS_ID//\"/}
USE_EXTERNAL_REPOS=${USE_EXTERNAL_REPOS:-true}
echo "[INFO] Installing requirements"
sudo apt install ca-certificates apt-transport-https curl software-properties-common certbot python3-certbot-apache -y
case $OS_ID in
    ubuntu)
        echo "Ubuntu"
        if [[ "$USE_EXTERNAL_REPOS" == "true" ]]; then
            sudo add-apt-repository ppa:ondrej/php -y
        else
            echo "[INFO] External repositories disabled, skipping PPA."
        fi
        ;;
    debian)
        echo "Debian"
        if [[ "$USE_EXTERNAL_REPOS" == "true" ]]; then
            sudo apt install ca-certificates apt-transport-https lsb-release gnupg -y
            sudo mkdir -p /etc/apt/keyrings
            curl -fsSL https://packages.sury.org/php/apt.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/sury-php.gpg
            echo "deb [signed-by=/etc/apt/keyrings/sury-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list > /dev/null
            sudo apt update
        else
            echo "[INFO] External repositories disabled, skipping Sury packages."
        fi
        ;;
    *)
        echo "Unknown distribution: $OS_ID"
        ;;
esac
sudo apt update
sudo apt install apache2 curl php php-apcu php-common php-curl php-gd php-gmp php-imagick php-intl php-json php-mbstring php-memcache php-mysql php-zip mariadb-server mariadb-client -y

mapfile -t php_versions < <(
    apt-cache search -n '^php[0-9]+\\.[0-9]+$' \
        | awk '{print $1}' \
        | sed 's/^php//' \
        | sort -V \
        | awk -F. '($1 > 8) || ($1 == 8 && $2 >= 1)'
)
if [ ${#php_versions[@]} -eq 0 ]; then
    php_versions=(8.1 8.2 8.3 8.4)
fi
for version in "${php_versions[@]}"; do
    if apt-cache show "php$version" >/dev/null 2>&1; then
        sudo apt install "php$version" "php$version-fpm" "libapache2-mod-php$version" \
            "php$version-apcu" "php$version-bcmath" "php$version-cli" "php$version-common" \
            "php$version-curl" "php$version-gd" "php$version-gmp" "php$version-imagick" \
            "php$version-intl" "php$version-mbstring" "php$version-memcache" \
            "php$version-mysql" "php$version-opcache" "php$version-phpdbg" \
            "php$version-readline" "php$version-xml" "php$version-zip" -y
    else
        echo "[WARN] PHP $version is not available in this repository, skipping."
    fi
done

echo "[INFO] enable required and recommended mods"
a2dissite 000-default
a2dissite default-ssl
apache_mods=(
    access_compat
    alias
    auth_basic
    authn_core
    authn_file
    authz_core
    authz_host
    authz_user
    autoindex
    brotli
    deflate
    dir
    filter
    headers
    http2
    macro
    mime
    mpm_prefork
    negotiation
    proxy
    proxy_fcgi
    proxy_fdpass
    proxy_html
    proxy_http
    proxy_http2
    proxy_wstunnel
    reqtimeout
    rewrite
    setenvif
    socache_shmcb
    ssl
    status
    vhost_alias
    xml2enc
)
for mod in "${apache_mods[@]}"; do
    if [ -e "/etc/apache2/mods-available/${mod}.load" ] || a2query -m "$mod" >/dev/null 2>&1; then
        a2enmod "$mod"
    else
        echo "[WARN] Apache module ${mod} is not available, skipping."
    fi
done
for version in "${php_versions[@]}"; do
    if [ -e "/etc/apache2/conf-available/php$version-fpm.conf" ]; then
        a2enconf "php$version-fpm"
    fi
done
echo "[INFO] Copy configuration files"
sudo cp sites/hosts.conf /etc/apache2/sites-available/hosts.conf
sudo cp sites/LE-template.conf /etc/apache2/sites-available/LE-template.conf
sudo cp conf/vHosts.conf /etc/apache2/conf-available/vHosts.conf
sudo cp conf/SSLvHosts.conf /etc/apache2/conf-available/SSLvHosts.conf
sudo cp conf/Proxys.conf /etc/apache2/conf-available/Proxys.conf
sudo cp conf/SSLProxys.conf /etc/apache2/conf-available/SSLProxys.conf
echo "[INFO] Enable config and vhosts-file"
a2ensite hosts.conf
a2enconf vHosts.conf
a2enconf SSLvHosts.conf
a2enconf SSLProxys.conf
a2enconf Proxys.conf
echo "[INFO] Restart apache2"
systemctl restart apache2
echo "[INFO] Installation successfully completed"
