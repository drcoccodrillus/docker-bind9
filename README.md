# docker-bind9
A dockerized and customizable DNS Server based on [bind9](https://www.isc.org/bind/)

***

## General description

This Docker image is based on the [ubuntu/bind9](https://hub.docker.com/r/ubuntu/bind9) image maintained by Canonical.

### Dockerfile

The Docker file copies the custom configurations stored in the custom-config folder that setup Bind9 DNS Server.

### Docker compose

The docker-compose.yml define the followings:

| Image Name           | Container Name | Container IP | Network Name    | Subnet         | Gateway     |
|--------------------- | -------------- | ------------ | --------------- | -------------- | ----------- |
| drcoccodrillus/bind9 | bushido-bind9  | 172.100.0.2  | bushido-network | 172.100.0.0/24 | 172.100.0.1 |

### Custom configuration files

The custom-config folder stores the customized files needed to apply the following configuration to Bind9.

| Name Server         | A Record    |
| ------------------- | ----------- |
| ns1.bushido.local   | 172.100.0.2 |
| host1.bushido.local | 172.100.0.3 |
| host2.bushido.local | 172.100.0.4 |

| DNS Forwarder |
| ------------- |
| 8.8.8.8       |
| 8.8.4.4       |

If you need to change the DNS Server configuration you need to put your hands on the following files:
- db.bushido.local
- named.conf.local
- named.conf.local

***

## How to use it

Using this dockerized version of Bind9 is pretty simple. Just follow the steps below in order to make it working on your system.

### Clone the repository

`git clone git@github.com:drcoccodrillus/docker-bind9.git`

### Build the image

`docker-compose up --build -d`

### Launch two test containers

`docker run -d --rm --name=host1 --net=bushido-network --ip=172.100.0.3 --dns=172.100.0.2 ubuntu:22.04 /bin/bash -c "while :; do sleep 10; done"`

`docker run -d --rm --name=host2 --net=bushido-network --ip=172.100.0.4 --dns=172.100.0.2 ubuntu:22.04 /bin/bash -c "while :; do sleep 10; done"`

### Jump into container host1

`docker exec -it host1 /bin/bash`

### From host1 try to ping host2

`ping 172.100.0.4`
