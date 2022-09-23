#! /bin/bash
filename="id_rsa"
path="$HOME/.ssh"

if [ "$1" ]; then
  hostname=$1
  if [ "$2" ]; then
    username=$2
  else
    username="$USER"
  fi
  if [ "$3" ]; then
    port=$3
  else
    port=22
  fi
else
  # Read the host and username to store public key (the host/username accepting passwordless ssh from this computer)
  echo "What host you want to access with passwordless SSH from this computer?"
  read -r hostname
  
  echo "What is your username on $hostname? ($USER?)"
  read -r username

  echo "What is your port on $hostname? ($USER?)"
  read -r port

  if [ ! "$username" ]; then
    username="$USER"
  fi
fi

# Use provided comment or default to user@hostname
if [ -z "$COMMENT" ]; then
  COMMENT=$(whoami)@$(hostname)
fi

# Generate rsa files
if [ -f "$path"/$filename ]; then
  echo "RSA key exists on $path/$filename, using existing file"
else
  ssh-keygen -t rsa -f "$path/$filename" -C "$COMMENT"
  echo RSA key pair generated
fi

# Avoid duplicate keys in authorized_keys, user can run this all the time
echo "We need to log into $hostname as $username with port ""$port"" to set up your public key (hopefully last time you'll use password from this computer)"
cat "$path/$filename.pub" | ssh "$hostname" -l "$username" -p "$port" ' [ -d ~/.ssh ] || \
                                                             mkdir -p ~/.ssh ; \
                                                             cat > ~/.ssh/KEY ; \
                                                             KEY=$(cat ~/.ssh/KEY) ; \
                                                             export KEY ; \
                                                             grep -q "$KEY" ~/.ssh/authorized_keys || \
                                                             cat ~/.ssh/KEY >> .ssh/authorized_keys ; \
                                                             chmod 700 ~/.ssh ; \
                                                             chmod 600 ~/.ssh/authorized_keys ;
                                                             rm ~/.ssh/KEY'
status=$?

if [ $status -eq 0 ]; then
  echo "Set up complete, try to ssh to $hostname now at port ""$port"""
  exit 0
else
  echo "An error has occured"
  exit 255
fi
