  <body>
    <h1>Easy and Secure Apache2 Webserver Setup</h1>
    <div class="install-instructions">
      <p>For install use: bash setup.sh</p>
      <p>The script was tested on Ubuntu 22.04.1 LTS jammy.</p>
    </div>
    <div>
      <p>The script will install all required packages (apache2, php8.1 + mods, mariadb), activate recommended apache2 modules and copy config files for a secure and easy to handle webserver.</p>
    </div>
    <div class="config-instructions">
      <p>To use the webserver after install go to the file /etc/apache2/sites-available/hosts.conf.</p>
      <table>
        <tr>
          <th>vHost Type</th>
          <th>Instructions</th>
        </tr>
        <tr>
          <td>vHost on port 443 with SSL/TLS</td>
          <td>Use SSLVHost &lt;domain&gt; &lt;path&gt; &lt;certpath&gt; &lt;phpversion&gt;</td>
        </tr>
        <tr>
          <td>vHost on an specific port e.g 80 or 8080 WITHOUT SSL/TLS!</td>
          <td>Use VHost &lt;domain&gt; &lt;port&gt; &lt;path&gt; &lt;phpversion&gt;</td>
        </tr>
        <tr>
          <td>Reverse proxy</td>
          <td>Use Proxy &lt;domain&gt; &lt;port&gt; &lt;proxyip&gt; &lt;proxyport&gt; &lt;certpath&gt; &lt;phpversion&gt;</td>
        </tr>
      </table>
      <p>After that you have to reload the apache2 service with "systemctl apache2 reload"</p>
    </div>
    <div class="final-instruction">
      <p>That's all!</p>
    </div>
  </body>
