# Nginx Reverse Proxy 

> - **For the extended documentation, click** [here](extendedREADME.md)
> - **To read more about Vagrant and Virtual Machines, click** [here](https://github.com/naistangz/Technical_Training/tree/master/docs/Week7_VM)


## Introduction
Nginx is a popular open-source web server. It can be useful to run on a virtual machine when hosting multiple websites. The general solution for running two web servers on a single system is to either use multiple IP addresses or different port numbers.
This project demonstrates how to configure Nginx as a reverse proxy. 

**To get started download the zip file or** `git clone` this repository onto your local machine

**Option 1**
![screenshot_download_zip](zip_file_screenshot.jpeg) 

**Option 2**
Open up **Terminal** and enter the following 
```bash
git clone https://github.com/naistangz/nginx-reverse-proxy.git
```


## Prerequisites
You will need the following:

1. [Vagrant](https://www.vagrantup.com/downloads.html)
2. [Virtual Box](https://www.virtualbox.org/wiki/Downloads)
3. [Ruby - Preinstalled in Mac](https://www.ruby-lang.org/en/downloads/)
4. [Bundler](https://bundler.io/) or `gem install bundler` in **Terminal** after **Ruby** has been installed.


## Checking versions for dependencies
```bash
$ vagrant --version
Vagrant 2.2.9
```

```bash
$ ruby --version
ruby 2.3.7p456 (2018-03-28 revision 63024) [universal.x86_64-darwin18]
```

```bash
$ bundle --version
Bundler version 2.1.4
```

## Running the Virtual Machines
1.  Change directory (cd) into the project 
```bash
$ cd nginx-reverse-proxy
```

2. Run vagrant in the `nginx-reverse-proxy` folder 
```bash
$ vagrant up 
```

3. Once the virtual machines have run it should return:
```bash
Your app is ready and listening on port 3000
```

4. Enter the following links into the browser:

[http://development.local/](http://development.local/)

[http://development.local/fibonacci/8](http://development.local/fibonacci/8)

[http://development.local/posts](http://development.local/posts)
