### Using Certbot with Let's Encrypt

In this scenario, we are going to use a publicly trust CA Authority (Let's Encrypt) to issue the SSL Certificates

### Pre-Requisites
The need the following pre-conditions to do this:
- We need an Ubuntu VM that is reachable on Port 80 from Any IP on the internal (from Let's Encrypt).
- We need Certbot to be installed on the VM

### Installing Certbot and Nginx

Add Certbot PPA to the List of Repos on the Ubuntu Machine

```shell

sudo apt-get update
sudo apt-get install software-properties-common
sudo add-apt-repository universe
sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update

```

Install Nginx and Certbot
```shell
sudo apt-get install certbot python-certbot-nginx nginx-full
```

Let's make sure that we are able to get to the document root of the Nginx webserver

