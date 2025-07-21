#!/bin/bash
set -e

# ========== 1. Update and Install Core Packages ==========
apt-get update -y && apt-get upgrade -y
DEBIAN_FRONTEND=noninteractive apt-get install -y apache2 mysql-server curl git build-essential

# ========== 2. Install Node.js (LTS) ==========
curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
apt-get install -y nodejs

# ========== 3. Install PM2 ==========
npm install -g pm2

# ========== 4. Configure Apache for Reverse Proxy ==========
a2enmod proxy proxy_http
cat <<EOF > /etc/apache2/sites-available/000-default.conf
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html

    ProxyRequests Off
    ProxyPreserveHost On

    <Proxy *>
        Require all granted
    </Proxy>

    ProxyPass / http://localhost:3000/
    ProxyPassReverse / http://localhost:3000/
</VirtualHost>
EOF
systemctl restart apache2

# ========== 5. Clone Node.js Project ==========
cd /var/www/
rm -rf my-node-api || true
git clone https://github.com/THAKURkamlesh/my-node-api.git
cd my-node-api
npm install

# ========== 6. Secure MySQL & Create DB/User ==========
MYSQL_ROOT_PASSWORD=$(openssl rand -base64 12)
#MYSQL_APP_PASSWORD=$(openssl rand -base64 10)

# Save credentials
cat <<EOF > /root/mysql_credentials.txt
MySQL Root Password: $MYSQL_ROOT_PASSWORD
EOF
chmod 600 /root/mysql_credentials.txt

mysql -u root <<MYSQL_SCRIPT
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$MYSQL_ROOT_PASSWORD';
FLUSH PRIVILEGES;

MYSQL_SCRIPT

# ========== 7. Kill Any Existing Node Process ==========
pkill -f 'node /var/www/my-node-api/app.js' || true

# ========== 8. Run PM2 as ubuntu user ==========
sudo -u ubuntu -i bash <<'EOF'
cd /var/www/my-node-api
pm2 start app.js --name my-node-api
pm2 save
pm2 startup systemd -u ubuntu --hp /home/ubuntu
EOF

echo "✅ Installation complete. App is running at http://<your-ip>:80"
yes