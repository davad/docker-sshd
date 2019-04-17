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
