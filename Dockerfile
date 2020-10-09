
ARG _TAG=3.9-alpine3.12
FROM python:${_TAG}
# https://hub.docker.com/_/python?tab=tags&page=1&name=-alpine

MAINTAINER iganari

### OS Prepare
# Setting timezone
RUN apk --update add tzdata make nginx vim && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    apk del tzdata && \
    rm -rf /var/cache/apk/*

RUN mkdir /run/nginx && \
    chmod 0777 -R /run/nginx
ADD nginx/nginx.conf /etc/nginx/
ADD nginx/sites-enabled /etc/nginx/sites-enabled

ADD requirements.txt /tmp
RUN pip3 install -r /tmp/requirements.txt

CMD nginx -g "daemon off;"
