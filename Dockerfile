

FROM node

MAINTAINER Steve Harris <shatro@aetrix.com>

ARG gid=1001
ARG uid=1001

# Prepare the Sinopia working/storage directories
RUN mkdir -p /opt/sinopia/log
RUN mkdir -p /opt/sinopia/storage
RUN mkdir -p /opt/sinopia/conf

# Add our "sinopia" user and make the directories accessible
RUN addgroup --gid $gid sinopia
RUN adduser --disabled-password --gid $gid --uid $uid --gecos "Sinopia NPM Repository" sinopia
RUN chown -R sinopia:sinopia /opt/sinopia

# Install the sinopia that we need
USER sinopia
WORKDIR /home/sinopia
ADD node/package.json /home/sinopia/package.json
RUN npm install sinopia2

# Add our auxilliary files need for initialization
ADD conf/base-config.yml /home/sinopia/base-config.yml
ADD bin/setup-sinopia.sh /home/sinopia/setup-sinopia.sh

WORKDIR /opt/sinopia

# Set our persistent volumes
VOLUME /opt/sinopia

# Expose the NPM Repo port
EXPOSE 4873

# Run the setup (this initializes directories/data as needed, then starts)
CMD /home/sinopia/setup-sinopia.sh


