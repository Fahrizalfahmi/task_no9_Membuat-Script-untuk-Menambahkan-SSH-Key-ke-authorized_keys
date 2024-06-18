#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <public_key_file> <username>"
    exit 1
fi

public_key_file="$1"
username="$2"
authorized_keys_file="/home/$username/.ssh/authorized_keys"

if [ ! -f "$public_key_file" ]; then
    echo "Error: Public key file '$public_key_file' not found."
    exit 1
fi

getent passwd "$username" >/dev/null
if [ $? -ne 0 ]; then
    echo "Error: User '$username' not found."
    exit 1
fi

mkdir -p "/home/$username/.ssh"
chmod 700 "/home/$username/.ssh"
touch "$authorized_keys_file"
chmod 600 "$authorized_keys_file"

cat "$public_key_file" >> "$authorized_keys_file"
echo "Public key added to $authorized_keys_file for user $username."
