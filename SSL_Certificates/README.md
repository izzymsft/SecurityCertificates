
# SSL Certificates

This is a tutorial on how to do the following:

- Setting Up OpenSSL for Creating Certificates as a Certificate Authority
- Issuing SSL Certificates


## Setting Up OpenSSL for Creating Certificates as a Certificate Authority

OpenSSL 1.02g or later is required for this tutorial.

If openssl is not yet installed, please install it

```shell
sudo su -

# aptitude install openssl libcurl4-openssl-dev
```


### Step 1. Create a directory called ca_authority

```shell
# mkdir ca_authority
```

### Step 2. Change Directory Permissions
Change the permissions on the folder to make it accessible only to the root user.

```shell
# chmod 0700 ca_authority
```

### Step 3. Storage Directories for Certificates and Private Keys
Inside the new directory, create two directories that will be used to store new certificates and private keys

```shell
# cd ca_authority

# mkdir certs private
```

### Step 4. Tracking Issued Certificates

Next we need to keep track of each certificate that is created and signed

The auto-increment serial number will be stored in the file called serial and the certificate database will be stored in a file called certindex.txt

Inside the ca_authority folder, run the following commands:

```shell
# echo '100001' > serial && touch certindex.txt
```

### Step 5. Configuring OpenSSL for Issuing Certs

Inside the ca_authority directory, create a custom configuration file for openssl to use. Feel free to update its contents to suit you needs.

```shell

touch openssl.cnf

$ vim openssl.cnf
```

### Step 6. Create the root certificate.

Since you are going to be the certification authority, all the certificates you create will
have the information in this root certificate as the issuer. Please make sure that it is valid.
Most browsers complain since you are not a commercial certificate issuing authority so you will
have to manually import the certificate into the browsers so that the error or warning messages will not occur
for any of the certificates you are going to sign.

This will be valid for 10 years (3652 days)

```shell
# openssl req -new -x509 -extensions v3_ca -keyout private/ca_key.key -out ca_cert.crt -days 3653 -config ./openssl.cnf
```

The above example should create a root certificate that is valid for approximately 10 years

### Step 7. (Optional) Installing your root certificate

This is a public certificate that you can make available for anyone to install in their browsers.

In firefox, you just have to open the certificate file and following the installation prompts.

The name of the public certificate file generated is ca_cert.crt


##  Issuing SSL Certificates - Creating the CSR and Private Key in One Step

We are going to create an X.509 openssl certificate

For each domain name you want to set up, create the key and signing request in one step :

### Step 1 - Create the Private Key and CSR

```shell
# cd ca_authority

# openssl req -new -out izzywebsite.csr -keyout private/izzywebsite.key -days 365 -config ./openssl.cnf
```

### Step 2. Sign the CSR

```shell
 openssl ca -config openssl.cnf -out product-api.crt -days 365 -infiles product-api.csr
# openssl ca -out izzywebsite.crt -days 365 -config ./openssl.cnf -infiles izzywebsite.csr
```

In the example above, these are the files generated and thier significance

- izzywebsite.csr is the Certificate Signing Request
- izzywebsite.key is the Private Key for this Certificate
- izzywebsite.crt is the SSL certificate that has been signed by the Certificate issuer.

You can place the generator.sh file in your ca_authority folder and use it to generate the certificates in an automated way
Simply specify the domain name as the first arguement to the ./generator.sh script and follow the prompt

If you need to reset the certificates database, you can execute the ./reset-database.sh script to do so

Info on Additional Commands is available here
https://www.sslshopper.com/article-most-common-openssl-commands.html

