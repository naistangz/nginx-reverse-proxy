#!/bin/bash

# Update the sources list
sudo apt-get update -y

# upgrade any packages available
sudo apt-get upgrade -y

# install nginx
sudo apt-get install nginx -y

# install git
sudo apt-get install git -y

# install nodejs
sudo apt-get install python-software-properties
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install nodejs -y

# installing npm 
npm install

# install pm2
sudo npm install pm2 -g

# setting up the nginx reverse proxy

# sudo rm /etc/nginx/sites-enabled/default
sudo unlink /etc/nginx/sites-enabled/default
sudo ln -s /home/ubuntu/environment/default /etc/nginx/sites-enabled/default
sudo systemctl start nginx
sudo systemctl stop nginx
sudo systemctl restart nginx
sudo systemctl status nginx

