
## Certificate and Key Conversions

On this page, we have guidance on how to do the following:
- remove passwords from private keys
- convert from PEM to PFX format
- convert from PEM to DER format


### Removing the Password on the Private Keys

To convert the private key to one without a password issue the following
command

```shell
openssl rsa -in /path/to/originalkeywithpass.key -out /path/to/newkeywithnopass.key
```

### Converting from PEM to PFX Format

This will prompt you for a password, please make a note of the password you selected for the private key. You will need it later

```shell
openssl pkcs12 -export -inkey privkey1.pem -in cert1.pem -out ouput.pfx 
```
### Converting from PEM to DER (Azure App Gateway CER)

This will prompt you for a password, please make a note of the password you selected for the private key. You will need it later

```shell
openssl x509 -inform PEM -in input.pem -outform DER -out output.cer

openssl x509 -inform PEM -in trust.pem -outform DER -out trust.cer
```

