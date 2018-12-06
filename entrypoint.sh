#!/bin/sh

# Generate host keys if not present
ssh-keygen -A

# Disable password authentication
sed -i "s/#PasswordAuthentication.*/PasswordAuthentication no/" /etc/ssh/sshd_config


# Create accounts for users and fetch keys
if [ "$USERS" ]; then
    echo $USERS
    for i in "$USERS"; do
        addgroup -S $i && adduser -S $i -G $i

        # disable password access, unlock account, set shell
        usermod -p '*' $i
        passwd -u $i
        usermod -s '/bin/bash' $i
        tail /etc/passwd

        HOME="/home/${i}"
        if [ -n "$GITHUB" ]; then
            echo "Import keys"
            mkdir -p "${HOME}/.ssh"
            wget -O - "https://github.com/${i}.keys" >> "${HOME}/.ssh/authorized_keys"
        fi
    done
fi

# do not detach (-D), log to stderr (-e), passthrough other arguments
exec /usr/sbin/sshd -D -e "$@"
