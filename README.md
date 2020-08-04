# Dependencies Prerequisites
1. [Vagrant](https://www.vagrantup.com/downloads.html)
2. [Virtual Box](https://www.virtualbox.org/wiki/Downloads)
3. [Ruby - Preinstalled in Mac](https://www.ruby-lang.org/en/downloads/)
4. [Bundler](https://bundler.io/) or `gem install bundler` in **Terminal** after **Ruby** has been installed.

**For the extended documentation, click** [here](extendedREADME.md)
## Checking versions for dependencies
```bash
Anaiss-MacBook-Pro:nginx-reverse-proxy anaistang$ vagrant --version
Vagrant 2.2.9
Anaiss-MacBook-Pro:nginx-reverse-proxy anaistang$ ruby --version
ruby 2.3.7p456 (2018-03-28 revision 63024) [universal.x86_64-darwin18]
Anaiss-MacBook-Pro:nginx-reverse-proxy anaistang$ bundle --version
Bundler version 2.1.4
```

# Git Clone this repository onto your local machine 
`git clone` [https://github.com/naistangz/nginx-reverse-proxy.git](https://github.com/naistangz/nginx-reverse-proxy.git)

# cd into the project 
`Anaiss-MacBook-Pro: cd nginx-reverse-proxy`

# Run vagrant in the directory
`Anaiss-MacBook-Pro: cd nginx-reverse-proxy`

`vagrant up` in Terminal

# Configuring NGINX as a Reverse Proxy
**All NGINX configuration files are located in the `/etc/nginx/` directory.**

**Navigate to `/etc/nginx/` directory**
```bash
vagrant@ubuntu-xenial:/home/ubuntu/app$ cd /etc/nginx/
```

**Changing directory to sites-available**
```bash
vagrant@ubuntu-xenial:/etc/nginx$ ls
conf.d        fastcgi_params  koi-win     nginx.conf    scgi_params      sites-enabled  uwsgi_params
fastcgi.conf  koi-utf         mime.types  proxy_params  sites-available  snippets       win-utf
vagrant@ubuntu-xenial:/etc/nginx$ cd sites-available
```

**Navigating to the configuration file**
```bash
vagrant@ubuntu-xenial:/etc/nginx/sites-available$ ls
default
vagrant@ubuntu-xenial:/etc/nginx/sites-available$ nano default
vagrant@ubuntu-xenial:/etc/nginx/sites-available$ sudo rm -r default
vagrant@ubuntu-xenial:/etc/nginx/sites-available$ sudo -i touch default
vagrant@ubuntu-xenial:/etc/nginx/sites-available$ sudo nano default
```

**Changing the file** `/etc/nginx/sites-enabled/default`
```bash
server {
    listen 80;
    server_name _;
    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```
- The `listen` directive tells NGINX the hostname/IP and the Transmission Control Protocol (TCP) port where it should listen for HTTP connections
- TCP is one of the main protocols of the Internet protocol suite. It is a connection-oriented communications protocol that facilitates the exchange of messages between computing devices in a network.
- The `server_name` directive allows multiple domains to be served from a single IP address.
- The `location` setting lets you configure **how** NGINX will respond to requests for resources within the server. 
- The `proxy_pass` is used when there is an **nginx instance** that handles many things, and delegates some of those requests to other servers.

## Automating set up for reverse proxy
1. Create a `default` file with the correct configuration to set up the reverse proxy in the `environment/app` folder on the local machine

2. In the `Vagrantfile`, sync this folder with a folder in the `app vm`
    ```bash
   app.vm.synced_folder "environment/app", "/home/ubuntu/environment" 
   ```
3. In `environment/app/provision.sh` provision script, use the symbolic link to link the `/home/ubuntu/environment` folder to a folder in the appropriate location.
```bash
sudo unlink /etc/nginx/sites-enabled/default
sudo ln -s /home/ubuntu/environment/default /etc/nginx/sites-enabled/default

```

4. Restart `NGINX` in order to effect changes
```bash
sudo systemctl restart nginx
```

5. Check status of `NGINX` server
```bash
vagrant@ubuntu-xenial:/etc/nginx/sites-available$ sudo systemctl status nginx 
● nginx.service - A high performance web server and a reverse proxy server
   Loaded: loaded (/lib/systemd/system/nginx.service; enabled; vendor preset: enabled)
   Active: active (running) since Thu 2020-07-30 08:22:37 UTC; 21min ago
  Process: 5384 ExecStop=/sbin/start-stop-daemon --quiet --stop --retry QUIT/5 --pidfile
  Process: 5393 ExecStart=/usr/sbin/nginx -g daemon on; master_process on; (code=exited,
  Process: 5388 ExecStartPre=/usr/sbin/nginx -t -q -g daemon on; master_process on; (cod
 Main PID: 5398 (nginx)
    Tasks: 3
   Memory: 2.2M
      CPU: 375ms
   CGroup: /system.slice/nginx.service
           ├─5398 nginx: master process /usr/sbin/nginx -g daemon on; master_process on
           ├─5399 nginx: worker process                           
           └─5400 nginx: worker process                           
Jul 30 08:22:37 ubuntu-xenial systemd[1]: Starting A high performance web server and a r
Jul 30 08:22:37 ubuntu-xenial systemd[1]: Started A high performance web server and a re
lines 1-17/17 (END)
```

6. **Testing the configuration file**
```bash
root@ubuntu-xenial:/home/ubuntu/app# nginx -t
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
```

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
