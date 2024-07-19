sudo apt update -y
sudo apt install nginx -y
sudo systemctl enable nginx && sudo systemctl start nginx
sudo iptables -I INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 443 -j ACCEPT
sudo ufw allow http
sudo ufw allow https
sudo apt install mariadb-server mariadb-client -y
sudo systemctl enable mariadb && sudo systemctl start mariadb
sudo apt install php php-fpm -y

nginx_version=$(nginx -v 2>&1); echo $version | grep -o '[0-9.]*'
php_version=php -v | grep ^PHP | cut -d' ' -f2
db_version=mysql -V | awk '{sub(/,$/,"",$5);print $5}'


# Display generated passwords to log file.
echo "................................................................"
echo ".....          The installation was successfull            ....."
echo "................................................................"
echo "Nginx: " $nginx_version
echo "PHP: " $php_version
echo "Database: " $db_version
echo "................................................................"
