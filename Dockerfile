FROM alpine:3.8
LABEL maintainer="https://github.com/davad/docker-sshd"

RUN apk update \
      && apk upgrade \
      && apk add openssh python bash \
      && mkdir -p /root/.ssh \
      && rm -rf /var/cache/apk/* /tmp/*

ADD entrypoint.sh /

EXPOSE 22
ENTRYPOINT ["/entrypoint.sh"]
