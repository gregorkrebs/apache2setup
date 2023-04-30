  <body>
    <h1>Easy and Secure Apache2 Webserver Setup</h1>
    <div class="install-instructions">
      <p>For install use: >> bash setup-ubuntu.sh << (For Ubuntu) or >> bash setup-debian.sh << (If you use Debian)</p>
      <p>The script was tested on Ubuntu 22.04.1 LTS jammy.</p>
    </div>
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
      
      (*) ⚠ Note: You need a valid SSL certificate. Certbot does not work yet. This configuration is perfect for a Cloudflare proxied web server with a Cloudflare CA-certificate.
          ⚠ You need 3 certificate files. First: privkey.pem, second: cert.pem, third: ca.pem (you can paste the content of cert.pem into ca.pem to get a ca certificate.
      



  </div>
    <div class="final-instruction">
      <p>That's all!</p>
    </div>
  </body>
