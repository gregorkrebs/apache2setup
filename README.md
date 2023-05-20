  <body>
    <h1>Easy and Secure Apache2 Webserver Setup</h1>
    <div class="install-instructions">
      <p>For install use: >> bash setup-ubuntu.sh << (For Ubuntu) or >> bash setup-debian.sh << (If you use Debian)</p>
      <p>The script was tested on Ubuntu 22.04.1 LTS jammy and Debian 11.</p>
    </div>
	<hr>
    <div>
      <p>The script will install all required packages (apache2, php (7.4, 8.0, 8.1, 8.2 + mods, mariadb), activate recommended apache2 modules and copy config files for a secure and easy to handle webserver.</p>
    </div>
    <div class="config-instructions">
      <p>To use the webserver after install go to the file /etc/apache2/sites-available/hosts.conf</p>
      <table>
        <tr>
          <th>vHost Type</th>
          <th>Instructions</th>
        </tr>
        <tr>
          <td>vHost on port 443 with SSL/TLS</td>
          <td>Use SSLvHost &lt;domain&gt; &lt;path&gt; &lt;certpath&gt;(⚠ Please note footnote) &lt;phpversion (7.4/8.0/8.1/8.2)&gt;</td>
        </tr>
        <tr>
          <td>vHost on an specific port e.g 80 or 8080 WITHOUT SSL/TLS</td>
          <td>Use vHost &lt;domain&gt; &lt;port&gt; &lt;path&gt; &lt;phpversion (7.4/0.0/8.1/8.2)&gt;</td>
        </tr>
        <tr>
          <td>Reverse SSL-proxy with SSL/TLS</td>
          <td>Use SSLProxy &lt;domain&gt; &lt;port&gt; &lt;protocol&gt; &lt;proxyip&gt; &lt;proxyport&gt; &lt;certpath&gt;(⚠ Please note footnote) &lt;phpversion (7.4/8.0/8.1/8.2)&gt;</td>
        </tr>
        <tr>
          <td>Reverse proxy WITHOUT SSL/TLS</td>
          <td>Use Proxy &lt;domain&gt; &lt;port&gt; &lt;protocol&gt; &lt;proxyip&gt; &lt;proxyport&gt; &lt;phpversion (7.4/8.0/8.1/8.2)&gt;</td>
        </tr>
      </table>
      <p>After that you have to reload the apache2 service with "systemctl reload apache2"</p><br>
      
      (*) ⚠ Note: You need a valid SSL certificate. This configuration is perfect when you have your own SSL certificate or for a Cloudflare proxied web server with a Cloudflare CA-certificate.
          ⚠ You need min 2 certificate files. First: privkey.pem, second: cert.pem. (Optional ca.pem. However, this must be activated in the Config)
  </div>
<hr>
      <p>Use Let's Encrypt / Certbot</p>
      1. Copy /etc/apache2/sites-available/LE-template.conf to /etc/apache2/sites-available/yourdomain.tld.conf<br>
      2. Edit /etc/apache2/sites-available/yourdomain.tld.conf and replace ALL [YOURDOMAIN.TLD] with your Domain.<br>
      3. Create directory "mkdir /var/www/youtdomain.tld", set the rights "chown -R www-data:www-data /var/www/yourdomain.tld" and activate your site with "a2ensite yourdomain.tld.conf"<br>
      4. Now run certbot with "certbot --apache". Follow the instructions.<br>
  <div class="final-instruction">
      <p><br>That's all!</p>
    </div>
  </body>
