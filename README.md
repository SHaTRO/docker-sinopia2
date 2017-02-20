# docker-sinopia2
Docker and Compose for Sinopia (npm install sinopia2) fork maintained by fl4re (https://github.com/fl4re/sinopia)

## Setup
1. Be sure you have docker-compose.  There is a script to install it here: [install-docker-compose](https://gist.github.com/SHaTRO/dbf0d02984156adfd83d0d1f17b2c5fe).
2. Prepare a local volume and user to use with the service (you can easily maintain from the host this way):
    ```bash
sudo mkdir -p /opt/sinopia  
sudo addgroup --gid 130 sinopia  
sudo adduser --disabled-password --home /opt/sinopia --gid 130 --uid 130 --gecos "Sinopia NPM Repository" sinopia  
sudo chown -R sinopia:sinopia /opt/sinopia
```
3. Prepare the sinopia build context (suggested):
    `sudo mkdir -p /usr/local/etc/compose/sinopia`  
    `sudo chown \`id -u\`:\`id -g\` /usr/local/etc/compose/sinopia`  
    `cd /usr/local/etc/compose/sinopia`  
    `git clone git@github.com:SHaTRO/docker-sinopia2.git .`  
4. Build the container to verify all is well:
    `docker-compose build sinopia`  

## Docker
The Dockerfile can be easily used without docker-compose:
```bash
docker build --tag `whoami`/sinopia:latest .
docker run --detach -p 4873:4873 --name sinopia `whoami`/sinopia:latest
docker stop sinopia
docker start sinopia
```

## Compose
The existing docker-compose.yml file contains a volume mapping to attach to the above created local volume.
It also hard codes the user id and group id to use for the user associated with the same.  
Customize these if needed.


## Setting up your npm to use Sinopia
See the docs associated with sinopia2 on this.  

