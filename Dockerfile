FROM ubuntu/bind9:latest

RUN apt-get update && apt-get upgrade -y

COPY custom-config/named.conf.options /etc/bind/
COPY custom-config/named.conf.local /etc/bind/
COPY custom-config/db.bushido.local /etc/bind/zones/
