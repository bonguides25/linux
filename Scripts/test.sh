sudo apt update -y
sudo apt install nginx -y
sudo systemctl enable nginx && sudo systemctl start nginx
sudo iptables -I INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 443 -j ACCEPT
sudo ufw allow http
sudo ufw allow https
sudo apt install mariadb-server mariadb-client -y
sudo systemctl enable mariadb && sudo systemctl start mariadb
sudo apt install php7.4 php7.4-fpm -y
