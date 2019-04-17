#!/bin/sh
set -e

# Generate host keys if not present
ssh-keygen -A

# Disable password authentication
sed -i "s/#PasswordAuthentication.*/PasswordAuthentication no/" /etc/ssh/sshd_config


# Create accounts for users and fetch keys
if [ "$USERS" ]; then
    for i in $USERS; do
	echo "Creating user ${i}"
        addgroup -S $i && adduser -S $i -G $i

        # disable password access, unlock account, set shell
        usermod -p '*' $i
        passwd -u $i
        usermod -s '/bin/bash' $i

        HOME="/home/${i}"
        if [ -n "$GITHUB" ]; then
            echo "Importing keys from GitHub"
            mkdir -p "${HOME}/.ssh"
            wget -O - "https://github.com/${i}.keys" >> "${HOME}/.ssh/authorized_keys"
        fi
    done
fi

# do not detach (-D), log to stderr (-e), passthrough other arguments
exec /usr/sbin/sshd -D -e "$@"
