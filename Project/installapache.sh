#!/bin/bash
sudo su
dpkg --configure -a
sudo apt-get -y update
sudo apt-get -y install apache2
sudo systemctl enable apache2 
# write some HTML
echo '<html><center><h1>Hello! Welcome to Web Sever !!</h1></center></html>'  > /var/www/html/index.html
sudo systemctl restart apache2