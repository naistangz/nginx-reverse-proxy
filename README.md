# Nginx Reverse Proxy 

## What is Nginx?
- Nginx is an open source high performance web server (stores, processes and delivers web pages to users) that powers many modern web applications. 
- Nginx excels at serving static content, integrates with other applications to deliver dynamic sites, and can also function as a load-balancer (efficient distribution of network/application traffic across multiple servers) and proxy server (intermediary for requests from clients).

## What is a reverse proxy?
- A server that sits in front of web servers and forwards clients requests (e.g. web browser) to those web servers.
- Reverse proxies are typically implemented to help increase security, performance and reliability.

## What is a proxy server?
- A forward proxy, often called a proxy, proxy server, web proxy, is a server that sits in front of a group of client machines
- When those computers make requests to sites and services on the Internet, the proxy server intercepts those requests and then communicates with web servers on behalf of those clients, like an intermediary. 

<img src="https://www.cloudflare.com/img/learning/cdn/glossary/reverse-proxy/forward-proxy-flow.svg" alt="forward proxy flow">

- A: This is a user's home computer 
- B: This is a forward proxy server
- C: This is a website's origin server (where the website data is stored)

In a standard internet communication, computer **A** would reach out directly to computer **C**, with the client requests to the *origin server* and the origin server responding to the client.
- When a forward proxy is in place, **A** will send requests to **B**, which will then forward the request to **C**. **C** will then send a response to B, which will forward the response back to **A**.

Adding an intermediary (a forward proxy) to our internet activity achieves the following:
1. **Avoids state or institutional browsing restrictions**
    - Governments, schools, organisations use firewalls to give their users access to a limited version of the Internet.
    - A forward proxy can be used to get around these restrictions, as they let the user connect to the proxy rather than directly to the sites they are visiting.
    
2. **Blocks access to certain content**
    - E.g. a school network might be configured to connect to the web through a proxy which enables content filtering rules, refusing to forward responses from certain social media sites.
    
3. **Protects identify online**
    - Regular Internet users want increased anonymity
    - Using a forward proxy, only the IP address will be visible, making it harder to trace back the user.

## Reverse Proxy
- A reverse proxy is a server that sits in front of one or more web servers, intercepting requests from clients
- This is different from **forward proxy**, where the proxy sits in front of the clients.
- A reverse proxy are intercepted at the **network edge** by the reverse proxy server
- The reverse proxy server will then send requests to and receive responses from the origin server.

Forward Proxy | Reverse Proxy
-----|------
Sits in front of a client|Sits in front of an origin server 
Ensures no origin server ever communicates directly with that specific client| Ensures that no client ever communicates directly with that origin server

<img src="https://www.cloudflare.com/img/learning/cdn/glossary/reverse-proxy/reverse-proxy-flow.svg" alt="reverse_proxy_flow">

## Proxies and Load Balancers
- A server running as a proxy or load balancer sits between a client and some resources that can fulfill requests from the client. 
- The client connects to the proxy or load balancer on the front-end and then the proxy connects to the server or resource on the back-end and returns the response to the client.
- A popular website that gets millions of users every day may not be able to handle all of its incoming site traffic with a single origin server.
- Instead, the site can be distributed among of a pool of different servers.
    -  A reverse proxy can provide a load balancing solution to distribute the incoming traffic evenly among different servers to prevent any single server from becoming overloaded.
- **Caching** - A reverse proxy can also *cache* content, resulting in faster performance.
    - Example: If a user in Madrid visits a reverse-proxied website with web servers in London, the user might actually connect to a local reverse proxy server in Madrid, which will then have to communicate with an origin server in London. 
    - The proxy server can then cache (temporarily save) the response data.
    - Subsequent users in Madrid who browse the site will then get the locally cached version from the Madrid reverse proxy server, resulting in faster performance. 

# Dependencies Prerequisites
1. [Vagrant](https://www.vagrantup.com/downloads.html)
2. [Virtual Box](https://www.virtualbox.org/wiki/Downloads)
3. [Ruby - Preinstalled in Mac](https://www.ruby-lang.org/en/downloads/)
4. [Bundler](https://bundler.io/) or `gem install bundler` in **Terminal** after **Ruby** has been installed.

## Checking versions for dependencies
```bash
Anaiss-MacBook-Pro:nginx-reverse-proxy anaistang$ vagrant --version
Vagrant 2.2.9
Anaiss-MacBook-Pro:nginx-reverse-proxy anaistang$ ruby --version
ruby 2.3.7p456 (2018-03-28 revision 63024) [universal.x86_64-darwin18]
Anaiss-MacBook-Pro:nginx-reverse-proxy anaistang$ bundle --version
Bundler version 2.1.4
```

# Run vagrant in the correct directory
`Anaiss-MacBook-Pro: cd name_of_folder`
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
