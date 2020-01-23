
# How to Create RSA Private and Public Keys
This set of instructions assume that your are running these steps on a UNIX machine such as Mac OS X, RHEL, CentOS or Ubuntu.

## Step 1: 
Navigate to your local SSH directory and if this directory does not exist, please create it by following the steps below:

```shell
mkdir -p ~/.ssh && cd ~/.ssh
```

## Step 2: 
Run the following command to generate the public and private key for the user Arnold Schwarzenegger. Then change the permissions to be readable by only your user. The username in this example is just hypothetical. Please modify the username to match your Enterprise ID. For this example user, the public and private key files achwarzenegger.pub and achwarzenegger respectively will be generated in the ~/.ssh directory.

```shell

ssh-keygen -b 2048 -t rsa -N '' -f achwarzenegger -C "aws-achwarzenegger"
chmod 0600 ~/.ssh/* 

```

## Step 3: 
Send the public key file such as achwarzenegger.pub to the server administrator granting access to the remote machine

## Step 4: 
Use your private key to connect to the remote SSH node
To log in to the server from a UNIX machine, this is the syntax:
```shell
ssh -i path_to_private_key username@hostname
```

Here is an example where the username  achwarzenegger uses the private key located in ~/.ssh/achwarzenegger to authenticate against the hostname 127.0.0.1

```shell
ssh -i ~/.ssh/achwarzenegger achwarzenegger@127.0.0.1
```
