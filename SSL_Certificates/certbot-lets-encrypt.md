### Using Certbot with Let's Encrypt

In this scenario, we are going to use a publicly trust CA Authority (Let's Encrypt) to issue the SSL Certificates

### Pre-Requisites
The need the following pre-conditions to do this:
- We need an Ubuntu VM that is reachable on Port 80 from Any IP on the internal (from Let's Encrypt).
- We need Certbot to be installed on the VM
- All the Domains or Sub-Domains you need to Issue SSL Certs for should map to the Public IP of the Linux VM 

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

### Verify that the Webserver is Reachable from the Internet

Let's make sure that we are able to get to the document root of the Nginx webserver on the Ubuntu machine.
If it is not reachable, we need to open up port 80 and 443 at the firewalls or Network Security Groups associated with the machine for this to be possible.

Also make sure that the DNS records for all your domains you wish to issue certs for are mapped to the public IP of your VM.

For the DNS record updates, you may need to change the A or CNAME records for the domains/sub-domains

### Generating the SSL Certificate from Let's Encrypt using Certbot

Specify the admin email and the FQDN of the hostname you wish to issue the SSL Certificate for

```shell
certbot certonly --nginx -m ssl@izzyacademy.com --agree-tos -d sample-domain.izzyacademy.com
```

This will generate the public and private certs for the hostname.

Once the cert is generated, we will need to generate the PFX and DER equivalents so that we have it readily-available if needed.


```shell
# Generate the PFX equivalent of the PEM cert
openssl pkcs12 -export -inkey privkey1.pem -in cert1.pem -out cert1.pfx 

# Generate the DER equivalent of the PEM cert
openssl x509 -inform PEM -in cert1.pem -outform DER -out cert1.cer
```
