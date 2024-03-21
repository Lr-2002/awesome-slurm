#!/bin/bash

# Function to check if the input username exists
check_username() {
    local user=$1
    if id "$user" &>/dev/null; then
        echo "Username '$user' exists."
        username="$user"
    else
        echo "Username '$user' does not exist. Using current user."
        username=$(whoami)
    fi
}

# Check if username is provided as argument
if [ $# -eq 1 ]; then
    check_username "$1"
else
    username=$(whoami)
fi

# Find the username
echo "Username: $username"

# Run the command 'squeue -u username'
squeue -u "$username"

