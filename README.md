Easy Apache2 Setup Script

For install use: bash setup.sh

The script was tested on Ubuntu Ubuntu 22.04.1 LTS jammy.

The script will install all required packages (apache2, php8.1 + mods, mariadb), activate recommended apache2 modules and copy config files for a secure and easy to handle webserver.

To use the webserver after install go to the file /etc/apache2/sites-available/hosts.conf and add your custom VHost (with an without SSL or reverse proxy)
After that you have to reload the apache2 service with "systemctl apache2 reload"

That's all!
