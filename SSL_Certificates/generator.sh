#/bin/bash

subdomain=$1

certificate_directory="${subdomain}_certificates"

csr_file="${certificate_directory}/${subdomain}.csr"

private_key="${certificate_directory}/${subdomain}.key"

certificate_file="${certificate_directory}/${subdomain}.crt"

der_certificate="${certificate_directory}/${subdomain}.cer"

pfx_certificate="${certificate_directory}/${subdomain}.pfx"

program_name=generator.sh

# Final Output Directory - Change this to match your environment
final_output_directory="/mnt/c/Users/isekpo/Documents/cert-generators"

# Admin UNIX Username - Change to match your environment
admin_username=iekpo

# Admin UNIX Group - Change to match your environment
admin_usergroup=iekpo

if [ $# -eq 0 ]; then
    echo "Usage: $program_name domainname"
    exit 1
fi

# Create the Base Directories
mkdir -p ${certificate_directory} ${final_output_directory}

# Generate the CSR and Private Key
echo "Starting Automation"
echo ""
echo "Generating the CSR and Private Key"
echo ""
openssl req -new -config openssl.cnf -out $csr_file -keyout $private_key -days 365

# Sign the CSR
echo "Signing the CSR and Creating the PEM Certificate"
echo ""
openssl ca -config openssl.cnf -out $certificate_file -days 365 -infiles $csr_file

# Convert PEM to DER/CER Format
echo "Converting the PEM Certificate to DER/CER Format for Azure"
echo ""
openssl x509 -inform PEM -in ${certificate_file} -outform DER -out ${der_certificate}

# Convert PEM to PFX Format
echo "Converting the PEM Certificate to PFX Format"
echo ""
openssl pkcs12 -export -inkey ${private_key} -in ${certificate_file} -out $pfx_certificate

# Copying Final Certs to Output Folder"
echo "Copying Certs to Final Output Directory $final_output_directory"

chown -R ${admin_username}:${admin_usergroup} $certificate_directory

cp -pvr $certificate_directory $final_output_directory

echo ""
echo "Automation Complete"
echo ""