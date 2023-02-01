Easy and Secure Apache2 Webserver Setup

For install use: bash setup.sh

The script was tested on Ubuntu Ubuntu 22.04.1 LTS jammy.

The script will install all required packages (apache2, php8.1 + mods, mariadb), activate recommended apache2 modules and copy config files for a secure and easy to handle webserver.

To use the webserver after install go to the file /etc/apache2/sites-available/hosts.conf.

For a SSL-VHost on port 443 with SSL/TLS use this in hosts.conf
Use SSLVHost <domain> <path> <certpath> <phpversion>

For a VHost with an specific port e.g 80 or 8080 WITHOUT SSL/TLS! use this in hosts.conf
Use VHost <domain> <port> <path> <phpversion>

For a reverse proxy use this in hosts.conf 
Use Proxy <domain> <port> <proxyip> <proxyport> <certpath> <phpversion>

After that you have to reload the apache2 service with "systemctl apache2 reload"

That's all!
