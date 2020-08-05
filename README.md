# Nginx Reverse Proxy App
## Introduction
Nginx is a popular open-source web server. It can be useful to run on a virtual machine when hosting multiple websites. The general solution for running two web servers on a single system is to either use multiple IP addresses or different port numbers.
This project demonstrates how to configure Nginx as a reverse proxy. 

**To get started download the zip file**

![screenshot_download_zip](zip_file_screenshot.jpeg) 


## Prerequisites
You will need the following:

1. [Vagrant](https://www.vagrantup.com/downloads.html)
2. [Virtual Box](https://www.virtualbox.org/wiki/Downloads)
3. [Ruby - Preinstalled in Mac](https://www.ruby-lang.org/en/downloads/)
4. [Bundler](https://bundler.io/) or `gem install bundler` in **Terminal** after **Ruby** has been installed.

**For the extended documentation, click** [here](extendedREADME.md)
**To read more about Vagrant and Virtual Machines, click** [here](https://github.com/naistangz/Technical_Training/tree/master/docs/Week7_VM)

## Checking versions for dependencies
```bash
Anaiss-MacBook-Pro:nginx-reverse-proxy anaistang$ vagrant --version
Vagrant 2.2.9
Anaiss-MacBook-Pro:nginx-reverse-proxy anaistang$ ruby --version
ruby 2.3.7p456 (2018-03-28 revision 63024) [universal.x86_64-darwin18]
Anaiss-MacBook-Pro:nginx-reverse-proxy anaistang$ bundle --version
Bundler version 2.1.4
```

## Git Clone this repository onto your local machine 
`git clone` [https://github.com/naistangz/nginx-reverse-proxy.git](https://github.com/naistangz/nginx-reverse-proxy.git)

## cd into the project 
`Anaiss-MacBook-Pro: cd nginx-reverse-proxy`

## Run vagrant in the directory
`Anaiss-MacBook-Pro: cd nginx-reverse-proxy`

`vagrant up` in Terminal

# Running the app

**File path:** `cd /home/ubuntu/app/app.js`

**Run the app** `node app.js`

**Enter the following links into the browser when you see the following:**
```bash
vagrant@ubuntu-xenial:/home/ubuntu/app$ node app.js
Your app is ready and listening on port 3000
```

`http://development.local/`

`http://development.local/fibonacci/8`

`http://development.local/posts`
