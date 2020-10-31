# docker-sshd
SSH daemon, sshuttle server, automatic pubkey import, Alpine linux

# Example docker-compose.yml file

```
version: '3.3'
services:
    sshd:
        image: davad/sshd
        ports:
            - "2222:22"
        environment:
            USERS: "davad"
            GITHUB: 1
```

This compose file stands up an sshd container listening on port 2222. User
`davad` can ssh in using any private key associated with his GitHub account.

# Bitbucket integration

If you prefer Bitbucket, the container will automatically fetch your pubkey
from their API if you set the `BITBUCKET` and `APP_PASSWORD` environmental
variables.

## Example
```
version: '3.3'
services:
    sshd:
        image: davad/sshd
        ports:
            - "2222:22"
        environment:
            USERS: "davad"
            BITBUCKET: 1
            APP_PASSWORD: "12345"
```

## Caveat

With Bitbucket, you can only fetch your own SSH pubkeys. If you specify a
username other than your own, the container will fail to start.
